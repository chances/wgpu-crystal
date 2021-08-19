require "future"

require "./lib-wgpu"
require "./colors"

# TODO: Write documentation for `Wgpu`
module WGPU
  extend self

  VERSION = "0.9.0"

  COPY_BYTES_PER_ROW_ALIGNMENT = 256
  DESIRED_NUM_FRAMES           =   3
  MAX_ANISOTROPY               =  16
  MAX_COLOR_TARGETS            =   4
  MAX_MIP_LEVELS               =  16
  MAX_VERTEX_BUFFERS           =  16

  enum ShaderStage : UInt8
    None     = 0
    Vertex   = 1
    Fragment = 2
    Compute  = 4
  end
  enum BufferUsage : UInt16
    MapRead  =   1
    MapWrite =   2
    CopySrc  =   4
    CopyDst  =   8
    Index    =  16
    Vertex   =  32
    Uniform  =  64
    Storage  = 128
    Indirect = 256
  end
  enum TextureUsage : UInt8
    CopySrc          =  1
    CopyDst          =  2
    Sampled          =  4
    Storage          =  8
    OutputAttachment = 16
  end
  alias BufferMapAsyncStatus = LibWGPU::BufferMapAsyncStatus
  enum LogLevel : UInt32
    Off = LibWGPU::LogLevel::Off
    Error = LibWGPU::LogLevel::Error
    Warning = LibWGPU::LogLevel::Warn
    Info = LibWGPU::LogLevel::Info
    Debug = LibWGPU::LogLevel::Debug
    Trace = LibWGPU::LogLevel::Trace
  end

  def set_log_level(level : LogLevel)
    LibWGPU.set_log_level LibWGPU::LogLevel.new(level.value)
  end

  alias LogCallback = Proc(LogLevel, String, Nil)
  @@log_callback = Pointer(Void).null
  def set_log_callback(callback : LogCallback)
    @@log_callback = Box.box(callback)
    LibWGPU.set_log_callback(->(level : LibWGPU::LogLevel, message : Char*) {
      return if @@log_callback.null?
      cb = Box(LogCallback).unbox(@@log_callback)
      cb.call LogLevel.new(level.value), String.new(message.as(UInt8*))
    })
  end

  # A resource managed internally by the underlying WebGPU implementation.
  abstract class WgpuId
    @id : Pointer(Void) = Pointer(Void).null

    def finalize
      @id = Pointer(Void).null
    end

    def id
      @id
    end

    # Whether this managed WebGPU resource reference is valid.
    def is_valid?
      @id.null?
    end

    def to_unsafe
      @id
    end
  end

  # TODO: wgpu-native doesn't use instances at the moment
  # https://github.com/gfx-rs/wgpu-native/issues/116#issuecomment-873296219
  # class Instance < WgpuId
  #   def initialize()
  #     descriptor = LibWGPU::InstanceDescriptor.new()
  #     @id = LibWGPU.create_instance(pointerof(descriptor))
  #   end
  # end

  class Surface < WgpuId
    private def initialize(descriptor : LibWGPU::SurfaceDescriptor)
      @id = LibWGPU.instance_create_surface(nil, pointerof(descriptor))
    end

    def self.from_metal_layer(label : String, layer : Void*)
      metal_layer_descriptor = LibWGPU::SurfaceDescriptorFromMetalLayer.new layer: layer
      descriptor = LibWGPU::SurfaceDescriptor.new(
        label: label, next_in_chain: pointerof(metal_layer_descriptor)
      )
      return Surface.new(nil, descriptor)
    end

    def self.from_windows_hwnd(label : String, hinstance : Void*, hwnd : Void*)
      windows_hwnd_descriptor = LibWGPU::SurfaceDescriptorFromWindowsHWND.new(hinstance: hinstance, hwnd: hwnd)
      descriptor = LibWGPU::SurfaceDescriptor.new(
        label: label, next_in_chain: pointerof(windows_hwnd_descriptor)
      )
      return Surface.new(nil, descriptor)
    end

    def self.from_xlib(label : String, display : Void*, window : UInt32)
      xlib_descriptor = LibWGPU::SurfaceDescriptorFromXlib.new(
        display: display, window: window
      )
      descriptor = LibWGPU::SurfaceDescriptor.new(
        label: label, next_in_chain: pointerof(xlib_descriptor)
      )
      return Surface.new(nil, descriptor)
    end
  end

  private ADAPTER_MUST_BE_READY = "Graphics adapter must be ready"

  class Adapter < WgpuId
    @@chan = Channel(Adapter).new
    @@callback_box : Pointer(Void)?

    private def initialize(adapter_id : LibWGPU::Adapter)
      @id = adapter_id
    end

    def self.request(compatible_surface : Surface? = nil)
      @@chan = Channel(Adapter).new if @@chan.closed?
      pp @@chan
      callback = ->(adapter_id : LibWGPU::Adapter) { spawn { @@chan.send self.new(adapter_id) } }
      callback_boxed = Box.box(callback)
      @@callback_box = callback_boxed

      # TODO: Add configurable backends when `AdapterExtras` lands
      # https://github.com/gfx-rs/wgpu-native/blob/b10496e7eed9349f0fd541e6dfe5029cb436de74/ffi/wgpu.h#L27-L30
      # allowed_backends = LibWGPU::BackendType::Vulkan | LibWGPU::BackendType::Metal | LibWGPU::BackendType::D3D11 | LibWGPU::BackendType::D3D12
      options = LibWGPU::RequestAdapterOptions.new
      options.compatible_surface = compatible_surface unless compatible_surface.nil?
      puts "Requesting graphics adapter…"
      LibWGPU.instance_request_adapter(nil, pointerof(options), ->(adapter_id : LibWGPU::Adapter, data : Void*) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(adapter_id)
      }, callback_boxed)

      return future {
        adapter = @@chan.receive
        @@chan.close
        puts "Received requested graphics adapter"
        adapter
      }
    end

    def is_ready?
      @id.null? == false
    end

    # Deprecated: Since wgpu-native 0.7
    def info
      return self.properties
    end

    def properties
      raise ADAPTER_MUST_BE_READY unless self.is_ready?
      info = LibWGPU::AdapterProperties.new
      LibWGPU.adapter_get_properties(self, pointerof(info))
      return info
    end
  end

  class Device < WgpuId
    @@chan = Channel(Device).new
    @@callback_box : Pointer(Void)?

    def initialize(device_id : LibWGPU::Device)
      @id = device_id
    end

    def self.request(adapter : Adapter, label : String? = nil, trace_path : String? = nil)
      raise ArgumentError.new(message: ADAPTER_MUST_BE_READY) unless adapter && adapter.is_ready?

      @@chan = Channel(Device).new if @@chan.closed?
      callback = ->(device_id : LibWGPU::Device) { spawn { @@chan.send self.new(device_id) } }
      callback_boxed = Box.box(callback)
      @@callback_box = callback_boxed

      device_extras = LibWGPU::DeviceExtras.new(
        LibWGPU::ChainedStruct.new(s_type: LibWGPU::NativeSType::DeviceExtras.as(LibWGPU::SType)),
        max_bind_groups: 4
      )
      device_extras.label = label.to_unsafe.as(Char*) unless label.nil?
      device_extras.trace_path = trace_path.to_unsafe.as(Char*) unless trace_path.nil?
      device_descriptor = LibWGPU::DeviceDescriptor.new next_in_chain: pointerof(device_extras).as(LibWGPU::ChainedStruct*)
      puts "Requesting graphics device…"
      LibWGPU.adapter_request_device(adapter, pointerof(device_descriptor), ->(device_id : LibWGPU::Device, data : Void*) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(device_id)
      }, callback_boxed)

      return future {
        device = @@chan.receive
        @@chan.close
        puts "Received requested graphics device"
        device
      }
    end

    def queue
      Queue.new self
    end

    def create_buffer(descriptor : LibWGPU::BufferDescriptor)
      Buffer.new(self, descriptor)
    end

    def create_texture(descriptor : LibWGPU::TextureDescriptor)
      Texture.new(self, descriptor)
    end

    def create_command_encoder(descriptor : LibWGPU::CommandEncoderDescriptor)
      CommandEncoder.new(self, descriptor)
    end

    def poll(*args, force_wait = false)
      LibWGPU.device_poll(@id, force_wait)
    end
  end

  class Surface < WgpuId
  end

  class SwapChain < WgpuId
    def initialize(device : Device, surface : Surface, descriptor : LibWGPU::SwapChainDescriptor)
      @id = LibWGPU.device_create_swap_chain(device, surface, pointerof(descriptor))
    end
  end

  class Buffer < WgpuId
    @@callback_boxes : Array(Pointer(Void)?) = [] of Pointer(Void)?

    getter status : BufferMapAsyncStatus
    getter read_only : Bool

    def initialize(device : Device, descriptor : LibWGPU::BufferDescriptor)
      @status = BufferMapAsyncStatus::Unknown
      @read_only = true
      @id = LibWGPU.device_create_buffer(device, pointerof(descriptor))
    end

    def is_mapped?
      @status == BufferMapAsyncStatus::Success
    end

    def get_mapped_range(start : UInt64, size : UInt64)
      raise Exception.new(message: "must have successfully mapped buffer") unless @status == BufferMapAsyncStatus::Success

      bytes_ptr = LibWGPU.buffer_get_mapped_range(@id, start, size)
      Bytes.new(bytes_ptr.as(UInt8*), size, read_only: @read_only)
    end

    def map_read_async(start : UInt64, size : UInt64)
      @read_only = true

      callback = ->(status : BufferMapAsyncStatus) { @status = status }
      callback_boxed = Box.box(callback)
      @@callback_boxes.push callback_boxed

      LibWGPU.buffer_map_async(@id, LibWGPU::MapMode::Read, start, size, ->(status, data) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(status)
      }, callback_boxed)
    end

    def map_write_async(start : UInt64, size : UInt64)
      @read_only = false

      callback = ->(status : BufferMapAsyncStatus) { @status = status }
      callback_boxed = Box.box(callback)
      @@callback_boxes.push callback_boxed

      LibWGPU.buffer_map_async(@id, LibWGPU::MapMode::Write, start, size, ->(status : BufferMapAsyncStatus, data : Void*) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(status)
      }, callback_boxed)
    end

    def unmap
      LibWGPU.buffer_unmap(@id)
    end

    def finalize
      LibWGPU.buffer_destroy(@id)
    end
  end

  class Texture < WgpuId
    def initialize(device : Device, @descriptor : LibWGPU::TextureDescriptor)
      # https://github.com/gfx-rs/wgpu-native/blob/v0.6.0/src/device.rs#L308
      @id = LibWGPU.device_create_texture(device, pointerof(@descriptor))
    end

    def format
      @descriptor.format
    end

    def usage
      @descriptor.usage
    end

    def create_default_view
      TextureView.new(self)
    end

    def finalize
      LibWGPU.texture_destroy(@id)
    end
  end

  class TextureView < WgpuId
    def initialize(texture : Texture, descriptor : LibWGPU::TextureViewDescriptor? = nil)
      descriptor = LibWGPU::TextureViewDescriptor.new if descriptor.nil?
      tex_view_descriptor = descriptor.as(LibWGPU::TextureViewDescriptor)
      @id = LibWGPU.texture_create_view(texture, pointerof(tex_view_descriptor))
    end
  end

  class Queue < WgpuId
    def initialize(device : Device)
      @id = LibWGPU.device_get_queue(device)
    end

    def submit(command_buffers : Array(CommandBuffer))
      submit(Tuple.from command_buffers)
    end

    def submit(*command_buffers)
      raise ArgumentError.new(message: "must submit one or more command buffers") if command_buffers.empty?
      unless command_buffers.class.types.all? { |t| t == CommandBuffer }
        raise ArgumentError.new(message: "must submit only `CommandBuffer` objects")
      end
      command_buffer_ids = command_buffers.map(&.id)
      LibWGPU.queue_submit(@id, command_buffers.size, command_buffer_ids.to_a.to_unsafe)
    end
  end

  class CommandBuffer < WgpuId
    def initialize(cmd_buffer : LibWGPU::CommandBuffer)
      @id = cmd_buffer
    end
  end

  class CommandEncoder < WgpuId
    def initialize(device : Device, descriptor : LibWGPU::CommandEncoderDescriptor)
      @id = LibWGPU.device_create_command_encoder(device, pointerof(descriptor))
    end

    def begin_render_pass(descriptor : LibWGPU::RenderPassDescriptor)
      LibWGPU.command_encoder_begin_render_pass(self, pointerof(descriptor))
    end

    def copy_texture_to_buffer(source : LibWGPU::ImageCopyTexture, destination : LibWGPU::ImageCopyBuffer, copy_size : LibWGPU::Extent3D)
      LibWGPU.command_encoder_copy_texture_to_buffer(self, pointerof(source), pointerof(destination), pointerof(copy_size))
    end

    def finish
      descriptor = LibWGPU::CommandBufferDescriptor.new
      CommandBuffer.new LibWGPU.command_encoder_finish(self, pointerof(descriptor))
    end
  end
end

module WGPU::Origin3D
  ZERO = LibWGPU::Origin3D.new x: 0, y: 0, z: 0
end
