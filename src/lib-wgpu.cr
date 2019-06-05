@[Link(ldflags: "-L#{__DIR__}/../vendor/wgpu/target/debug -lwgpu_native")]
lib LibWGPU
  # struct WGPUColor
  #   r : LibC::Float
  #   g : LibC::Float
  #   b : LibC::Float
  #   a : LibC::Float
  # end

  # WGPUColor_TRANSPARENT = WGPUColor.new r: 0, g: 0, b: 0, a: 0
  # WGPUColor_BLACK       = WGPUColor.new r: 0, g: 0, b: 0, a: 1
  # WGPUColor_WHITE       = WGPUColor.new r: 1, g: 1, b: 1, a: 1
  # WGPUColor_RED         = WGPUColor.new r: 1, g: 0, b: 0, a: 1
  # WGPUColor_GREEN       = WGPUColor.new r: 0, g: 1, b: 0, a: 1
  # WGPUColor_BLUE        = WGPUColor.new r: 0, g: 0, b: 1, a: 1

  fun wgpu_create_instance : WGPUInstanceId
end
