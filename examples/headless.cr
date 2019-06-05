require "./../src/wgpu"

puts "Headless WebGPU Instance"

Signal::INT.trap { exit }

instance = WGPU::Instance.new

pp instance.id
