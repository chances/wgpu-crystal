require "./lib-wgpu"
require "./colors"

# TODO: Write documentation for `Wgpu`
module WGPU
  VERSION = "0.6.0"

  COPY_BYTES_PER_ROW_ALIGNMENT = 256
  DESIRED_NUM_FRAMES = 3
  MAX_ANISOTROPY = 16
  MAX_COLOR_TARGETS = 4
  MAX_MIP_LEVELS = 16
  MAX_VERTEX_BUFFERS = 16

  enum ShaderStage : UInt8
    None = 0
    Vertex = 1
    Fragment = 2
    Compute = 4
  end
  enum BufferUsage : UInt16
    MapRead = 1
    MapWrite = 2
    CopySrc = 4
    CopyDst = 8
    Index = 16
    Vertex = 32
    Uniform = 64
    Storage = 128
    Indirect = 256
  end
  enum TextureUsage : UInt8
    CopySrc = 1
    CopyDst = 2
    Sampled = 4
    Storage = 8
    OutputAttachment = 16
  end
  alias BufferMapAsyncStatus = LibWGPU::BufferMapAsyncStatus

  abstract class WgpuId
    @id : UInt64 = 0

    def id
      @id
    end

    def to_unsafe
      @id
    end
  end

  class Adapter < WgpuId
    @@callback_box : Pointer(Void)?

    def initialize(options : LibWGPU::RequestAdapterOptions)
      callback = ->(adapter_id : LibWGPU::AdapterId) { @id = adapter_id }
      callback_boxed = Box.box(callback)
      @@callback_box = callback_boxed

      allowed_backends = LibWGPU::Backend::Vulkan | LibWGPU::Backend::Metal | LibWGPU::Backend::Dx12
      LibWGPU.wgpu_request_adapter_async(pointerof(options), allowed_backends, false, ->(adapter_id, data) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(adapter_id)
      }, callback_boxed)
    end

    def is_ready?
      @id > 0
    end

    def info
      unless self.is_ready?
        raise Exception.new(message = "adapter must be ready")
      end
      info = LibWGPU::CAdapterInfo.new
      LibWGPU.wgpu_adapter_get_info(self, pointerof(info))
      return info
    end

    def finalize
      LibWGPU.wgpu_adapter_destroy(self)
    end
  end

  class Device < WgpuId
    def initialize(adapter : Adapter)
      unless adapter && adapter.is_ready?
        raise ArgumentError.new(message = "adapter must be ready")
      end
      limits = LibWGPU::CLimits.new max_bind_groups: 1
      @id = LibWGPU.wgpu_adapter_request_device(adapter, 0, pointerof(limits), true, nil)
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
      LibWGPU.wgpu_device_poll(@id, force_wait)
    end

    def finalize
      LibWGPU.wgpu_device_destroy(@id)
    end
  end

  class Surface < WgpuId
  end

  class SwapChain < WgpuId
    def initialize(device : Device, surface : Surface, swapChainDescriptor : LibWGPU::SwapChainDescriptor)
      @id = LibWGPU.wgpu_device_create_swap_chain(device, surface, pointerof(swapChainDescriptor))
    end
  end

  class Buffer < WgpuId
    @@callback_boxes : Array(Pointer(Void)?) = [] of Pointer(Void)?

    getter status : BufferMapAsyncStatus
    getter read_only : Bool

    def initialize(device : Device, descriptor : LibWGPU::BufferDescriptor)
      @status = BufferMapAsyncStatus::Unknown
      @read_only = true
      @id = LibWGPU.wgpu_device_create_buffer(device, pointerof(descriptor))
    end

    def is_mapped?
      @status == BufferMapAsyncStatus::Success
    end

    def get_mapped_range(start : UInt64, size : UInt64)
      raise Exception.new(message = "must have successfully mapped buffer") unless @status == BufferMapAsyncStatus::Success

      bytes_ptr = LibWGPU.wgpu_buffer_get_mapped_range(@id, start, size)
      Bytes.new(bytes_ptr, size, read_only: @read_only)
    end

    def map_read_async(start : UInt64, size : UInt64)
      @read_only = true

      callback = ->(status : BufferMapAsyncStatus) { @status = status }
      callback_boxed = Box.box(callback)
      @@callback_boxes.push callback_boxed

      LibWGPU.wgpu_buffer_map_read_async(@id, start, size, ->(status, data) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(status)
      }, callback_boxed)
    end

    def map_write_async(start : UInt64, size : UInt64)
      @read_only = false

      callback = ->(status : BufferMapAsyncStatus) { @status = status }
      callback_boxed = Box.box(callback)
      @@callback_boxes.push callback_boxed

      LibWGPU.wgpu_buffer_map_write_async(@id, start, size, ->(status, data) {
        cb = Box(typeof(callback)).unbox(data)
        cb.call(status)
      }, callback_boxed)
    end

    def unmap
      LibWGPU.wgpu_buffer_unmap(@id)
    end

    def finalize
      LibWGPU.wgpu_buffer_destroy(@id)
    end
  end

  class Texture < WgpuId
    def initialize(device : Device, @descriptor : LibWGPU::TextureDescriptor)
      # https://github.com/gfx-rs/wgpu-native/blob/v0.6.0/src/device.rs#L308
      @id = LibWGPU.wgpu_device_create_texture(device, pointerof(@descriptor))
    end

    def format
      @descriptor.format
    end

    def usage
      @descriptor.usage
    end

    def create_default_view()
      TextureView.new(self)
    end

    def finalize
      LibWGPU.wgpu_texture_destroy(@id)
    end
  end

  class TextureView < WgpuId
    def initialize(texture : Texture)
      @id = LibWGPU.wgpu_texture_create_view(texture, nil)
    end
    def initialize(texture : Texture, descriptor : LibWGPU::TextureViewDescriptor)
      @id = LibWGPU.wgpu_texture_create_view(texture, pointerof(descriptor))
    end

    def finalize
      LibWGPU.wgpu_texture_view_destroy(@id)
    end
  end

  class Queue < WgpuId
    def initialize(device : Device)
      @id = LibWGPU.wgpu_device_get_default_queue(device)
    end

    def submit(command_buffers : Array(CommandBuffer))
      submit(Tuple.from command_buffers)
    end
    def submit(*command_buffers)
      unless !command_buffers.empty? && command_buffers.class.types.all? { |t| t == CommandBuffer }
        raise ArgumentError.new(message = "must submit one or more command buffers")
      end
      command_buffer_ids = command_buffers.map { |buf| buf.id }
      LibWGPU.wgpu_queue_submit(@id, command_buffer_ids.to_a.to_unsafe, command_buffers.size)
    end
  end

  class CommandBuffer < WgpuId
    def initialize(id : UInt64)
      @id = id
    end

    def finalize
      LibWGPU.wgpu_command_buffer_destroy(self)
    end
  end

  class CommandEncoder < WgpuId
    def initialize(device : Device, descriptor : LibWGPU::CommandEncoderDescriptor)
      @id = LibWGPU.wgpu_device_create_command_encoder(device, pointerof(descriptor))
    end

    def begin_render_pass(descriptor : LibWGPU::RenderPassDescriptor)
      LibWGPU.wgpu_command_encoder_begin_render_pass(self, pointerof(descriptor))
    end

    def copy_texture_to_buffer(source : LibWGPU::TextureCopyView, destination : LibWGPU::BufferCopyView, copy_size : LibWGPU::Extent3d)
      LibWGPU.wgpu_command_encoder_copy_texture_to_buffer(self, pointerof(source), pointerof(destination), pointerof(copy_size))
    end

    def finish()
      descriptor = LibWGPU::CommandBufferDescriptor.new
      command_buffer_id = LibWGPU.wgpu_command_encoder_finish(self, pointerof(descriptor))
      CommandBuffer.new command_buffer_id
    end

    def finalize
      LibWGPU.wgpu_command_encoder_destroy(self)
    end
  end
end

module WGPU::Origin3d
  ZERO = LibWGPU::Origin3d.new x: 0, y: 0, z: 0
end
