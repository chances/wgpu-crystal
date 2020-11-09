require "./../src/wgpu"

# Adapted from https://github.com/gfx-rs/wgpu-rs/blob/master/examples/capture/main.rs

puts "Headless WebGPU Instance"

Signal::INT.trap { exit }

adapter = WGPU::Adapter.new(LibWGPU::RequestAdapterOptions.new power_preference: LibWGPU::PowerPreference::LowPower)
pp adapter.info
device = WGPU::Device.new adapter

width : UInt64 = 300
height : UInt64 = 400

# https://github.com/rukai/wgpu-rs/blob/f6123e4fe89f74754093c07b476099623b76dd08/examples/capture/main.rs#L53
bytes_per_pixel = sizeof(UInt32);
unpadded_bytes_per_row = width * bytes_per_pixel;
align = WGPU::COPY_BYTES_PER_ROW_ALIGNMENT;
padded_bytes_per_row_padding = (align - unpadded_bytes_per_row % align) % align;
padded_bytes_per_row = unpadded_bytes_per_row + padded_bytes_per_row_padding;

# The output buffer lets us retrieve data as an array
output_buffer = device.create_buffer(LibWGPU::BufferDescriptor.new(
  label: nil,
  size: padded_bytes_per_row * height,
  usage: WGPU::BufferUsage::MapRead | WGPU::BufferUsage::CopyDst,
  mapped_at_creation: false
))
texture_extent = LibWGPU::Extent3d.new width: width, height: height, depth: 1

# The render pipeline renders data into this texture
texture = device.create_texture(LibWGPU::TextureDescriptor.new(
  size: texture_extent,
  mip_level_count: 1,
  sample_count: 1,
  dimension: LibWGPU::TextureDimension::D2,
  format: LibWGPU::TextureFormat::Rgba8UnormSrgb,
  usage: WGPU::TextureUsage::OutputAttachment | WGPU::TextureUsage::CopySrc,
  label: nil
))
texture_view = texture.create_default_view()

# Set the background to be red
encoder = device.create_command_encoder(LibWGPU::CommandEncoderDescriptor.new label: nil)
color_attachment = LibWGPU::RenderPassColorAttachmentDescriptor.new(
  attachment: texture_view.id,
  resolve_target: 0,
  channel: LibWGPU::PassChannel_Color.new(
    load_op: LibWGPU::LoadOp::Clear,
    store_op: LibWGPU::StoreOp::Store,
    clear_value: WGPU::Colors::RED,
    read_only: false
  )
)
encoder.begin_render_pass(LibWGPU::RenderPassDescriptor.new(
  color_attachments: pointerof(color_attachment),
  depth_stencil_attachment: nil
))
# Copy the data from the texture to the buffer
encoder.copy_texture_to_buffer(LibWGPU::TextureCopyView.new(
  texture: texture.id,
  mip_level: 0,
  origin: WGPU::Origin3d::ZERO
), LibWGPU::BufferCopyView.new(
  buffer: output_buffer.id,
  layout: LibWGPU::TextureDataLayout.new(
    offset: 0,
    bytes_per_row: padded_bytes_per_row,
    rows_per_image: 0
  ),
), texture_extent)
command_buffer = encoder.finish()
device.queue.submit(command_buffer)

device.poll(force_wait: true)

# TODO: Write a bmp or png of the output

output_buffer.unmap()
