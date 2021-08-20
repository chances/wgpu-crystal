require "baked_file_system"

require "./../src/wgpu"
require "./framework.cr"

class Assets
  extend BakedFileSystem
  bake_folder "./assets/compute"

  def self.shader
    Assets.get("/shader.wgsl").gets_to_end
  end
end

puts "WebGPU Compute"

Signal::INT.trap { exit }

WGPU.set_log_level WGPU::LogLevel::Warning
WGPU.set_log_callback(->(level : WGPU::LogLevel, message : String) {
  puts "#{level}: #{message}"
})

adapter = WGPU::Adapter.request
pp adapter.get.info
device = WGPU::Device.request(adapter.get).get

# TODO: https://github.com/gfx-rs/wgpu-native/tree/v0.9.2.2/examples/compute

numbers = [1, 2, 3, 4]
