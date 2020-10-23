require "./lib-wgpu"

# TODO: Write documentation for `Wgpu`
module WGPU
  VERSION = "0.6.0"

  COPY_BYTES_PER_ROW_ALIGNMENT = LibWGPU::COPY_BYTES_PER_ROW_ALIGNMENT

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

  class Adapter
    @id : LibWGPU::AdapterId = 0
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

    def id
      @id
    end

    def to_unsafe
      @id
    end
  end

  class Device
    def initialize(adapter : Adapter)
      unless adapter && adapter.is_ready?
        raise ArgumentError.new(message = "adapter must be ready")
      end
      limits = LibWGPU::CLimits.new max_bind_groups: 1
      @id = LibWGPU.wgpu_adapter_request_device(adapter, 0, pointerof(limits), true, nil)
    end

    def id
      @id
    end

    def to_unsafe
      @id
    end

    def create_buffer(descriptor : LibWGPU::BufferDescriptor)
      LibWGPU.wgpu_device_create_buffer(self, pointerof(descriptor))
    end

    def create_texture(descriptor : LibWGPU::TextureDescriptor)
      LibWGPU.wgpu_device_create_texture(self, pointerof(descriptor))
    end
  end

  class Surface
    @@id : LibWGPU::SurfaceId?

    def id
      @@id
    end

    def to_unsafe
      @id
    end
  end

  class SwapChain
    def initialize(device : Device, surface : Surface, swapChainDescriptor : LibWGPU::SwapChainDescriptor)
      @swapchainId = LibWGPU.wgpu_device_create_swap_chain(device.id, surface.id, pointerof(swapChainDescriptor))
    end

    def id
      @swapchainId
    end

    def to_unsafe
      @id
    end
  end
end

module WGPU::Colors
  TRANSPARENT = LibWGPU::Color.new r: 0, g: 0, b: 0, a: 0
  BLACK       = LibWGPU::Color.new r: 0, g: 0, b: 0, a: 1
  WHITE       = LibWGPU::Color.new r: 1, g: 1, b: 1, a: 1
  RED         = LibWGPU::Color.new r: 1, g: 0, b: 0, a: 1
  GREEN       = LibWGPU::Color.new r: 0, g: 1, b: 0, a: 1
  BLUE        = LibWGPU::Color.new r: 0, g: 0, b: 1, a: 1
end
