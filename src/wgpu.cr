require "./lib-wgpu"

# TODO: Write documentation for `Wgpu`
module WGPU
  VERSION = "0.1.0"

  class Instance
    @@instanceId : LibWGPU::WGPUInstanceId?

    def initialize
      @@instanceId = LibWGPU.wgpu_create_instance
    end

    def id
      @@instanceId
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
