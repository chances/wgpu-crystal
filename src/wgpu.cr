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
  alias TextureFormat = LibWGPU::TextureFormat
  enum TextureUsage : UInt8
    CopySrc = LibWGPU::TextureUsage::CopySrc
    CopyDst = LibWGPU::TextureUsage::CopyDst
    Sampled = LibWGPU::TextureUsage::Sampled
    Storage = LibWGPU::TextureUsage::Storage
    # DEPRECATED: Since wgpu-native `0.7`, use `TextureUsage::RenderAttachment`.
    OutputAttachment = LibWGPU::TextureUsage::RenderAttachment
    RenderAttachment = LibWGPU::TextureUsage::RenderAttachment
  end
  alias BufferMapAsyncStatus = LibWGPU::BufferMapAsyncStatus
  enum LogLevel : UInt32
    Off     = LibWGPU::LogLevel::Off
    Error   = LibWGPU::LogLevel::Error
    Warning = LibWGPU::LogLevel::Warn
    Info    = LibWGPU::LogLevel::Info
    Debug   = LibWGPU::LogLevel::Debug
    Trace   = LibWGPU::LogLevel::Trace
  end

  def set_log_level(level : LogLevel)
    LibWGPU.set_log_level LibWGPU::LogLevel.new(level.value)
  end

  alias LogCallback = Proc(LogLevel, String, Nil)
  @@log_callback = Pointer(Void).null

  def set_log_callback(callback : LogCallback)
    @@log_callback = Box.box(callback)
    LibWGPU.set_log_callback(->(level : LibWGPU::LogLevel, message : UInt8*) {
      return if @@log_callback.null?
      cb = Box(LogCallback).unbox(@@log_callback)
      cb.call LogLevel.new(level.value), String.new(message)
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
      @id.null? == false
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

  alias SurfaceDescriptor = LibWGPU::SurfaceDescriptor

  class Surface < WgpuId
    getter descriptor : LibWGPU::SurfaceDescriptor

    private def initialize(@descriptor : LibWGPU::SurfaceDescriptor)
      @id = LibWGPU.instance_create_surface(nil, pointerof(@descriptor))
    end

    def self.from_metal_layer(label : String, layer : Void*) : Surface
      metal_layer_descriptor = LibWGPU::SurfaceDescriptorFromMetalLayer.new(
        chain: LibWGPU::ChainedStruct.new(s_type: LibWGPU::SType::SurfaceDescriptorFromMetalLayer),
        layer: layer
      )
      descriptor = LibWGPU::SurfaceDescriptor.new(
        next_in_chain: pointerof(metal_layer_descriptor).as(LibWGPU::ChainedStruct*),
        label: label
      )
      return self.new(descriptor)
    end

    def self.from_windows_hwnd(label : String, hinstance : Void*, hwnd : Void*) : Surface
      windows_hwnd_descriptor = LibWGPU::SurfaceDescriptorFromWindowsHWND.new(
        chain: LibWGPU::ChainedStruct.new(s_type: LibWGPU::SType::SurfaceDescriptorFromWindowsHWND),
        hinstance: hinstance,
        hwnd: hwnd
      )
      descriptor = LibWGPU::SurfaceDescriptor.new(
        next_in_chain: pointerof(windows_hwnd_descriptor).as(LibWGPU::ChainedStruct*),
        label: label
      )
      return self.new(descriptor)
    end

    def self.from_xlib(label : String, display : Void*, window : UInt32) : Surface
      xlib_descriptor = LibWGPU::SurfaceDescriptorFromXlib.new(
        chain: LibWGPU::ChainedStruct.new(s_type: LibWGPU::SType::SurfaceDescriptorFromXlib),
        display: display, window: window
      )
      descriptor = LibWGPU::SurfaceDescriptor.new(
        next_in_chain: pointerof(xlib_descriptor).as(LibWGPU::ChainedStruct*),
        label: label
      )
      return self.new(descriptor)
    end

    @@chan = Channel(TextureFormat).new
    @@callback_box : Pointer(Void)?
    # Lazy getter to retreive the preferred `TextureFormat` for this Surface.
    # Call `preferred_format(adapter : Adapter)` first.
    #
    # See Also: [`Future::Compute`](https://github.com/crystal-community/future.cr/blob/v1.0.0/src/future.cr#L7)
    getter preferred_format : Future::Compute(TextureFormat)?

    # Asynchronously retreive the preferred `TextureFormat` for this Surface.
    #
    # See Also: [`Future::Compute`](https://github.com/crystal-community/future.cr/blob/v1.0.0/src/future.cr#L7)
    def preferred_format(adapter : Adapter) : Future::Compute(TextureFormat)
      @@chan = Channel(TextureFormat).new if @@chan.closed?
      callback = ->(format : TextureFormat) { spawn { @@chan.send format } }
      callback_boxed = Box.box(callback)
      @@callback_box = callback_boxed

      puts "Requesting surface preferred texture format…" if @descriptor.label.null?
      puts "Requesting preferred texture format for #{@descriptor.label} surface…" unless @descriptor.label.null?
      LibWGPU.surface_get_preferred_format(self, adapter, ->(format : TextureFormat, data : Void*) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(format)
      }, callback_boxed)

      @preferred_format = future {
        format = @@chan.receive
        @@chan.close
        puts "Received requested surface texture format" if @descriptor.label.null?
        puts "Received requested texture format for #{@descriptor.label} surface…" unless @descriptor.label.null?
        format
      }
    end
  end

  private ADAPTER_MUST_BE_READY = "Graphics adapter must be ready"

  class Adapter < WgpuId
    @@chan = Channel(Adapter).new
    @@callback_box : Pointer(Void)?

    private def initialize(adapter_id : LibWGPU::Adapter)
      @id = adapter_id
    end

    # Asynchronously request a graphics Adapter.
    # Optionally, a `Surface` may be provided such that a compatible Adapter is selected.
    #
    # See Also: [`Future::Compute`](https://github.com/crystal-community/future.cr/blob/v1.0.0/src/future.cr#L7)
    def self.request(compatible_surface : Surface? = nil) : Future::Compute(Adapter)
      @@chan = Channel(Adapter).new if @@chan.closed?
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

    # DEPRECATED: Since wgpu-native `0.7`, use `Adapter.properties`.
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

    # Asynchronously request a graphics Device.
    #
    # See Also: [`Future::Compute`](https://github.com/crystal-community/future.cr/blob/v1.0.0/src/future.cr#L7)
    def self.request(adapter : Adapter, label : String? = nil, trace_path : String? = nil) : Future::Compute(Device)
      raise ArgumentError.new(message: ADAPTER_MUST_BE_READY) unless adapter && adapter.is_ready?

      @@chan = Channel(Device).new if @@chan.closed?
      callback = ->(device_id : LibWGPU::Device) { spawn { @@chan.send self.new(device_id) } }
      callback_boxed = Box.box(callback)
      @@callback_box = callback_boxed

      device_extras = LibWGPU::DeviceExtras.new(
        LibWGPU::ChainedStruct.new(s_type: LibWGPU::NativeSType::DeviceExtras.as(LibWGPU::SType)),
        max_bind_groups: 4
      )
      device_extras.label = label.to_unsafe unless label.nil?
      device_extras.trace_path = trace_path.to_unsafe unless trace_path.nil?
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

    def queue : Queue
      Queue.new self
    end

    def create_buffer(descriptor : LibWGPU::BufferDescriptor) : Buffer
      Buffer.new(self, descriptor)
    end

    def create_texture(descriptor : LibWGPU::TextureDescriptor) : Texture
      Texture.new(self, descriptor)
    end

    def create_shader_module(descriptor : LibWGPU::ShaderModuleDescriptor) : ShaderModule
      ShaderModule.new(self, descriptor)
    end

    def create_swap_chain(surface : Surface, descriptor : SwapChainDescriptor) : SwapChain
      SwapChain.new(self, surface, descriptor)
    end

    def create_pipeline_layout(layout : Array(BindGroupLayout) = [] of BindGroupLayout, *args, label : String? = nil) : PipelineLayout
      PipelineLayout.new(self, layout, label: label)
    end

    def create_render_pipeline(descriptor : LibWGPU::RenderPipelineDescriptor) : RenderPipeline
      RenderPipeline.new(self, descriptor)
    end

    def create_command_encoder(descriptor : LibWGPU::CommandEncoderDescriptor) : CommandEncoder
      CommandEncoder.new(self, descriptor)
    end

    def poll(*args, force_wait = false) : Void
      LibWGPU.device_poll(@id, force_wait)
    end
  end

  record Size, width : UInt32, height : UInt32 do
    def initialize(width : UInt32, height : UInt32)
      @width = width
      @height = height
    end
  end

  alias PresentMode = LibWGPU::PresentMode

  class SwapChainDescriptor < WgpuId
    private def initialize(@descriptor : LibWGPU::SwapChainDescriptor)
      @id = pointerof(@descriptor).as(Void*)
    end

    def to_unsafe
      @id.as(LibWGPU::SwapChainDescriptor*)
    end
  end

  class SwapChain < WgpuId
    getter descriptor : SwapChainDescriptor

    def initialize(device : Device, surface : Surface, @descriptor : SwapChainDescriptor)
      @id = LibWGPU.device_create_swap_chain(device, surface, @descriptor)
    end

    def usage
      @descriptor.usage
    end

    def format
      @descriptor.format
    end

    def width
      @descriptor.width
    end

    def height
      @descriptor.height
    end

    def size
      Size.new(width, height)
    end

    def present_mode
      @descriptor.present_mode
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

  class ShaderModule < WgpuId
    def initialize(device : Device, descriptor : LibWGPU::ShaderModuleDescriptor)
      @id = LibWGPU.device_create_shader_module(device, pointerof(descriptor))
    end

    def self.from_spirv(device : Device, spirv : Bytes, *args, label : String? = nil) : ShaderModule
      spirv_descriptor = LibWGPU::ShaderModuleSPIRVDescriptor.new(
        chain: LibWGPU::ChainedStruct.new(s_type: LibWGPU::SType::ShaderModuleSPIRVDescriptor),
        code_size: spirv.length,
        code: spirv
      )
      descriptor = LibWGPU::ShaderModuleDescriptor.new(
        next_in_chain: pointerof(spirv_descriptor).as(LibWGPU::ChainedStruct*)
      )
      descriptor.label = label unless label.nil?
      device.create_shader_module descriptor
    end

    def self.from_wgsl(device : Device, wgsl : String, *args, label : String? = nil) : ShaderModule
      wgsl_descriptor = LibWGPU::ShaderModuleWGSLDescriptor.new(
        chain: LibWGPU::ChainedStruct.new(s_type: LibWGPU::SType::ShaderModuleWGSLDescriptor),
        source: wgsl
      )
      descriptor = LibWGPU::ShaderModuleDescriptor.new(
        next_in_chain: pointerof(wgsl_descriptor).as(LibWGPU::ChainedStruct*)
      )
      descriptor.label = label unless label.nil?
      device.create_shader_module descriptor
    end
  end

  alias BindGroupLayoutEntry = LibWGPU::BindGroupLayoutEntry

  class BindGroupLayout < WgpuId
    getter label : String
    getter entries : Array(BindGroupLayoutEntry)

    def initialize(device : Device, @label : String, @entries : Array(BindGroupLayoutEntry))
      layout_descriptor = LibWGPU::BindGroupLayout.new(
        label: @label,
        entry_count: entries.size,
        entries: entries.to_unsafe
      )
      @id = LibWGPU.device_create_bind_group_layout(device, pointerof(layout_descriptor))
    end
  end

  alias VertexBufferLayout = LibWGPU::VertexBufferLayout

  class VertexState
    def self.from(shader : ShaderModule, *args, entry_point : String, buffers : Array(VertexBufferLayout) = [] of VertexBufferLayout)
      LibWGPU::VertexState.new(
        shader: shader,
        entry_point: entry_point,
        buffer_count: buffers.size,
        buffers: buffers.to_unsafe # VertexBufferLayout*
      )
    end
  end

  class BlendState
    @blend : LibWGPU::BlendState
    getter color_blend_func : LibWGPU::BlendComponent
    getter alpha_blend_func : LibWGPU::BlendComponent

    def initialize(*args, color : LibWGPU::BlendComponent, alpha : LibWGPU::BlendComponent)
      @blend = LibWGPU::BlendState.new(
        color: @color_blend_func = color,
        alpha: @alpha_blend_func = alpha
      )
    end

    def to_unsafe
      pointerof(@blend)
    end
  end

  module BlendComponent
    SRC_ONE_DST_ZERO_ADD = LibWGPU::BlendComponent.new(
      src_factor: LibWGPU::BlendFactor::One,
      dst_factor: LibWGPU::BlendFactor::Zero,
      operation: LibWGPU::BlendOperation::Add,
    )
  end

  alias ColorTargetState = LibWGPU::ColorTargetState

  class FragmentState
    @state : LibWGPU::FragmentState

    def initialize(shader : ShaderModule, *args, entry_point : String, targets : Array(ColorTargetState) = [] of ColorTargetState)
      @state = LibWGPU::FragmentState.new(
        shader: shader,
        entry_point: entry_point,
        target_count: targets.size, # UInt32
        targets: targets.to_unsafe
      )
    end

    def to_unsafe
      pointerof(@state)
    end
  end

  class PipelineLayout < WgpuId
    def initialize(device : Device, layout : Array(BindGroupLayout) = [] of BindGroupLayout, *args, label : String? = nil)
      layout_ids = layout.map(&.id)
      layout_descriptor = LibWGPU::PipelineLayoutDescriptor.new(
        bind_group_layout_count: layout.size,
        bind_group_layouts: layout_ids.to_a.to_unsafe.as(LibWGPU::BindGroupLayout*)
      )
      layout_descriptor.label = label unless label.nil?
      @id = LibWGPU.device_create_pipeline_layout(device, pointerof(layout_descriptor))
    end

    def self.empty(device : Device, *args, label : String? = nil)
      PipelineLayout.new(device, label: label)
    end
  end

  alias RenderPipelineDescriptor = LibWGPU::RenderPipelineDescriptor

  class RenderPipeline < WgpuId
    def initialize(device : Device, descriptor : LibWGPU::RenderPipelineDescriptor)
      @id = LibWGPU.device_create_render_pipeline(device, pointerof(descriptor))
    end

    # TODO: Add support for LibWGPU.device_create_render_pipeline_async
  end

  record Rectangle, x : UInt32, y : UInt32, width : UInt32, height : UInt32 do
    def top
      self.y
    end

    def right
      self.x + self.width
    end

    def bottom
      self.y + self.height
    end

    def left
      self.x
    end
  end

  # A render viewport region.
  #
  # See Also: `RenderPass.viewport=`
  record(Viewport,
    x : UInt32, y : UInt32,
    width : UInt32, height : UInt32,
    min_depth : Float32, max_depth : Float32
  )

  class RenderPass < WgpuId
    def initialize(encoder : LibWGPU::RenderPassEncoder)
      @id = encoder
    end

    def begin_occlusion_query(index : UInt32)
      LibWGPU.render_pass_encoder_begin_occlusion_query(self, index)
    end

    def begin_pipeline_statistics_query(set : LibWGPU::QuerySet, index : UInt32)
      LibWGPU.render_pass_encoder_begin_pipeline_statistics_query(self, set, index)
    end

    def draw(vertex_count : UInt32, instance_count : UInt32, first_vertex : UInt32, first_instance : UInt32)
      LibWGPU.render_pass_encoder_draw(self, vertex_count, instance_count, first_vertex, first_instance)
    end

    def draw_indexed(index_count : UInt32, instance_count : UInt32, first_index : UInt32, base_vertex : Int32, first_instance : UInt32)
      LibWGPU.render_pass_encoder_draw_indexed(
        self,
        index_count,
        instance_count,
        first_index,
        base_vertex,
        first_instance
      )
    end

    def draw_indexed_indirect(buf : Buffer, offset : UInt64)
      LibWGPU.render_pass_encoder_draw_indexed_indirect(self, buf, offset)
    end

    def draw_indirect(buf : Buffer, offset : UInt64)
      LibWGPU.render_pass_encoder_draw_indirect(self, buf, offset)
    end

    def end_occlusion_query
      LibWGPU.render_pass_encoder_end_occlusion_query(self)
    end

    def end_pass
      LibWGPU.render_pass_encoder_end_pass(self)
    end

    def end_pipeline_statistics_query
      LibWGPU.render_pass_encoder_end_pipeline_statistics_query(self)
    end

    def execute_bundles(bundles : Array(RenderBundle))
      bundle_ids = bindles.map(&.id)
      LibWGPU.render_pass_encoder_execute_bundles(
        self,
        bundles.size,
        bundle_ids.to_a.to_unsafe
      )
    end

    def insert_debug_marker(label : String)
      LibWGPU.render_pass_encoder_insert_debug_marker(self, label)
    end

    def pop_debug_group
      LibWGPU.render_pass_encoder_pop_debug_group(self)
    end

    def push_debug_group(label : String)
      LibWGPU.render_pass_encoder_push_debug_group(self, label)
    end

    def bind_group
      LibWGPU.render_pass_encoder_set_bind_group(self)
    end

    def blend_color=(color : LibWGPU::Color)
      LibWGPU.render_pass_encoder_set_blend_color(self, pointerof(color))
    end

    def set_index_buffer(buf : Buffer, format : LibWGPU::IndexFormat, offset : UInt64, size : UInt64)
      LibWGPU.render_pass_encoder_set_index_buffer(self, buf, format, offset, size)
    end

    def pipeline=(pipeline : RenderPipeline)
      LibWGPU.render_pass_encoder_set_pipeline(self, pipeline)
    end

    # Sets the scissor region.
    # Subsequent draw calls will discard any fragments that fall outside this region.
    def scissor_rect=(rect : Rectangle)
      LibWGPU.render_pass_encoder_set_scissor_rect(self, rect.x, rect.y, rect.width, rect.height)
    end

    # Subsequent stencil tests will test against this value.
    def stencil_reference=(ref : UInt32)
      LibWGPU.render_pass_encoder_set_stencil_reference(self, ref)
    end

    def set_vertex_buffer(slot : UInt32, buf : Buffer, offset : UInt64, size : UInt64)
      LibWGPU.render_pass_encoder_set_vertex_buffer(self, slot, buf, offset, size)
    end

    # Sets the viewport region.
    # Subsequent draw calls will draw any fragments in this region.
    def viewport=(view : Viewport)
      LibWGPU.render_pass_encoder_set_viewport(
        self, view.x, view.y, view.width, view.height, view.min_depth, view.max_depth
      )
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
      RenderPass.new LibWGPU.command_encoder_begin_render_pass(self, pointerof(descriptor))
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
