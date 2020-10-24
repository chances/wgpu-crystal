module WGPU::Colors
  TRANSPARENT = LibWGPU::Color.new r: 0, g: 0, b: 0, a: 0
  BLACK       = LibWGPU::Color.new r: 0, g: 0, b: 0, a: 1
  WHITE       = LibWGPU::Color.new r: 1, g: 1, b: 1, a: 1
  RED         = LibWGPU::Color.new r: 1, g: 0, b: 0, a: 1
  GREEN       = LibWGPU::Color.new r: 0, g: 1, b: 0, a: 1
  BLUE        = LibWGPU::Color.new r: 0, g: 0, b: 1, a: 1
end
