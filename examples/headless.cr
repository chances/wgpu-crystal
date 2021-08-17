require "stumpy_png"
include StumpyPNG

require "./../src/wgpu"

# Adapted from https://github.com/gfx-rs/wgpu-native/blob/v0.7.0.2/examples/capture/main.c

puts "Headless WebGPU Instance"

Signal::INT.trap { exit }

instance = WGPU::Instance.new
adapter = WGPU::Adapter.new(instance)
pp adapter.info
device = WGPU::Device.new adapter

width : Int32 = 300
height : Int32 = 400

# https://github.com/rukai/wgpu-rs/blob/f6123e4fe89f74754093c07b476099623b76dd08/examples/capture/main.rs#L53
bytes_per_pixel = sizeof(UInt32)
unpadded_bytes_per_row = width * bytes_per_pixel
align = WGPU::COPY_BYTES_PER_ROW_ALIGNMENT
padded_bytes_per_row_padding = (align - unpadded_bytes_per_row % align) % align
padded_bytes_per_row = unpadded_bytes_per_row + padded_bytes_per_row_padding
size = padded_bytes_per_row * height

# The output buffer lets us retrieve data as an array
output_buffer = device.create_buffer(LibWGPU::BufferDescriptor.new(
  label: nil,
  size: padded_bytes_per_row * height,
  usage: WGPU::BufferUsage::MapRead | WGPU::BufferUsage::CopyDst,
  mapped_at_creation: false
))
texture_extent = LibWGPU::Extent3D.new width, height, depth: 1

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
texture_view = texture.create_default_view()

# Set the background to be red
encoder = device.create_command_encoder(LibWGPU::CommandEncoderDescriptor.new label: nil)
color_attachment = LibWGPU::RenderPassColorAttachmentDescriptor.new(
  attachment: texture_view.id,
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
  texture: texture.id,
  mip_level: 0,
  origin: WGPU::Origin3D::ZERO
), LibWGPU::ImageCopyBuffer.new(
  buffer: output_buffer.id,
  layout: LibWGPU::TextureDataLayout.new(
    offset: 0,
    bytes_per_row: padded_bytes_per_row,
    rows_per_image: 0
  ),
), texture_extent)
command_buffer = encoder.finish()
device.queue.submit(command_buffer)

output_buffer.map_read_async(0, size.to_u64)

# Poll the device in a blocking manner so that map_read_async resolves.
# In an actual application, `device.poll(...)` should be called in an event loop or on another thread.
device.poll(force_wait: true)

pp output_buffer.status

canvas = Canvas.new(width, height)

if output_buffer.is_mapped?

  padded_buffer = output_buffer.get_mapped_range(0, size.to_u64)
  rows = padded_buffer.in_groups_of(padded_bytes_per_row, 0).map do |chunk|
    chunk[0..unpadded_bytes_per_row].in_groups_of(4, 0)
  end

  rows.each_index do |y|
    rows[y].each_index do |x|
      pixel = rows[y][x].map { |byte| byte.to_u16 }
      canvas[x, y] = RGBA.from_rgba_n(pixel, 8) unless x >= width
    end
  end

  StumpyPNG.write(canvas, "#{__DIR__}/red.png")
end

output_buffer.unmap()
