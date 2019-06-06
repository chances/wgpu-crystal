require "./../src/wgpu"

puts "Headless WebGPU Instance"

Signal::INT.trap { exit }

instance = WGPU::Instance.new
pp instance.id

adapter = WGPU::Adapter.new(instance, LibWGPU::WGPUAdapterDescriptor.new power_preference: LibWGPU::WGPUPowerPreference::LowPower)
pp adapter.id
