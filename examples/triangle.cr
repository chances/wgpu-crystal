require "./../src/wgpu"

puts "WebGPU Triangle"

Signal::INT.trap { exit }

adapter = WGPU::Adapter.new(LibWGPU::RequestAdapterOptions.new power_preference: LibWGPU::PowerPreference::LowPower)
pp adapter.info
device = WGPU::Device.new adapter

width : UInt64 = 300
height : UInt64 = 400

# TODO: Implement https://github.com/gfx-rs/wgpu-native/blob/master/examples/triangle/main.c
