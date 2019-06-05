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
