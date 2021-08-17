require "./../src/wgpu"

puts "WebGPU Triangle"

Signal::INT.trap { exit }

# TODO: Create a compatible surface to render to
# surface = LibWGPU::Surface.fromBlah
# adapter = WGPU::Adapter.new(LibWGPU::RequestAdapterOptions.new surface)
adapter = WGPU::Adapter.new
pp adapter.info
device = WGPU::Device.new adapter # ameba:disable Lint/UselessAssign

width : UInt64 = 300
height : UInt64 = 400

# TODO: Implement https://github.com/gfx-rs/wgpu-native/blob/master/examples/triangle/main.c
