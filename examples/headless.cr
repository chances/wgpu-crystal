require "./../src/wgpu"
require "./framework.cr"

# Adapted from https://github.com/gfx-rs/wgpu-native/blob/v0.9.2.2/examples/capture/main.c

puts "Headless WebGPU Instance"

Signal::INT.trap { exit }

WGPU.set_log_level WGPU::LogLevel::Warning
WGPU.set_log_callback(->(level : WGPU::LogLevel, message : String) {
  puts "#{level}: #{message}"
})

adapter = WGPU::Adapter.request
pp adapter.get.info
device = WGPU::Device.request(adapter.get).get

width : Int32 = 300
height : Int32 = 400
dimensions = Dimensions.new(width.to_u32, height.to_u32)

# The output buffer lets us retrieve data as an array
output_buffer = device.create_buffer(LibWGPU::BufferDescriptor.new(
  label: nil,
  size: dimensions.size_in_bytes,
  usage: WGPU::BufferUsage::MapRead | WGPU::BufferUsage::CopyDst,
  mapped_at_creation: false
))
texture_extent = LibWGPU::Extent3D.new width: width, height: height, depth: 1
pp texture_extent

# The render pipeline renders data into this texture
texture = device.create_texture(LibWGPU::TextureDescriptor.new(
  size: texture_extent,
  mip_level_count: 1,
  sample_count: 1,
  dimension: LibWGPU::TextureDimension::D2,
  format: LibWGPU::TextureFormat::RGBA8UnormSrgb,
  usage: WGPU::TextureUsage::OutputAttachment | WGPU::TextureUsage::CopySrc,
  label: nil
))
texture_view = texture.create_default_view

# Set the background to be red
encoder = device.create_command_encoder(LibWGPU::CommandEncoderDescriptor.new label: nil)
color_attachment = LibWGPU::RenderPassColorAttachmentDescriptor.new(
  attachment: texture_view,
  resolve_target: LibWGPU::TextureView.null,
  load_op: LibWGPU::LoadOp::Clear,
  store_op: LibWGPU::StoreOp::Store,
  clear_color: WGPU::Colors::RED
)
encoder.begin_render_pass(LibWGPU::RenderPassDescriptor.new(
  color_attachments: pointerof(color_attachment),
  color_attachment_count: 1,
  depth_stencil_attachment: nil
))
# Copy the data from the texture to the buffer
encoder.copy_texture_to_buffer(LibWGPU::ImageCopyTexture.new(
  texture: texture,
  mip_level: 0,
  origin: WGPU::Origin3D::ZERO
), LibWGPU::ImageCopyBuffer.new(
  buffer: output_buffer,
  layout: LibWGPU::TextureDataLayout.new(
    offset: 0,
    bytes_per_row: dimensions.padded_bytes_per_row,
    rows_per_image: 0
  ),
), texture_extent)
command_buffer = encoder.finish
device.queue.submit(command_buffer)

output_buffer.map_read_async(0, dimensions.size_in_bytes.to_u64)

# Poll the device in a blocking manner so that map_read_async resolves.
# In an actual application, `device.poll(...)` should be called in an event loop or on another thread.
device.poll(force_wait: true)

pp output_buffer.status

write_to_png("#{__DIR__}/red.png", output_buffer, dimensions)

output_buffer.unmap
