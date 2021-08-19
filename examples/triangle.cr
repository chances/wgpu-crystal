require "baked_file_system"

require "./../src/wgpu"

class Assets
  extend BakedFileSystem
  bake_folder "./assets/triangle"

  def self.shader
    Assets.get("/shader.wgsl").gets_to_end
  end
end

puts "WebGPU Triangle"

Signal::INT.trap { exit }

WGPU.set_log_level WGPU::LogLevel::Warning
WGPU.set_log_callback(->(level : WGPU::LogLevel, message : String) {
  puts "#{level}: #{message}"
})

# TODO: Create a compatible surface to render to?
# surface = LibWGPU::Surface.fromBlah
# adapter = WGPU::Adapter.new(LibWGPU::RequestAdapterOptions.new surface)

adapter = WGPU::Adapter.request
pp adapter.get.info
device = WGPU::Device.request(adapter.get).get

width : UInt64 = 300
height : UInt64 = 400

shader = WGPU::ShaderModule.from_wgsl(device, Assets.shader)
abort("Could not compile shader", 1) unless shader.is_valid?

# TODO: Implement https://github.com/gfx-rs/wgpu-native/blob/v0.9.2.2/examples/triangle/main.c#L137
