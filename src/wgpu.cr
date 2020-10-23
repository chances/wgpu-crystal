require "./lib-wgpu"

# TODO: Write documentation for `Wgpu`
module WGPU
  VERSION = "0.6.0"

  class Instance
    def initialize
      @instanceId = LibWGPU.wgpu_create_instance
    end

    def id
      @instanceId
    end
  end

  class Adapter
    def initialize(instance : Instance, adapterDescriptor : LibWGPU::WGPUAdapterDescriptor)
      unless instance
        raise ArgumentError.new(message = "instance must not be nil")
      else
        @adapterId = LibWGPU.wgpu_instance_get_adapter(instance.id, pointerof(adapterDescriptor))
      end
    end

    def id
      @adapterId
    end
  end

  class Device
    def initialize(adapter : Adapter, deviceDescriptor : LibWGPU::WGPUDeviceDescriptor)
      @deviceId = LibWGPU.wgpu_adapter_request_device(adapter.id, pointerof(deviceDescriptor))
    end

    def id
      @deviceId
    end
  end

  class Surface
    @@surfaceId : LibWGPU::WGPUSurfaceId?

    def id
      @@surfaceId
    end
  end

  class SwapChain
    def initialize(device : Device, surface : Surface, swapChainDescriptor : LibWGPU::WGPUSwapChainDescriptor)
      @swapchainId = LibWGPU.wgpu_device_create_swap_chain(device.id, surface.id, pointerof(swapChainDescriptor))
    end

    def id
      @swapchainId
    end
  end
end

module WGPU::Colors
  TRANSPARENT = WGPUColor.new r: 0, g: 0, b: 0, a: 0
  BLACK       = WGPUColor.new r: 0, g: 0, b: 0, a: 1
  WHITE       = WGPUColor.new r: 1, g: 1, b: 1, a: 1
  RED         = WGPUColor.new r: 1, g: 0, b: 0, a: 1
  GREEN       = WGPUColor.new r: 0, g: 1, b: 0, a: 1
  BLUE        = WGPUColor.new r: 0, g: 0, b: 1, a: 1
end
