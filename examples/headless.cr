require "./../src/wgpu"

puts "Headless WebGPU Instance"

Signal::INT.trap { exit }

adapter = WGPU::Adapter.new(LibWGPU::RequestAdapterOptions.new power_preference: LibWGPU::PowerPreference::LowPower)
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

# TODO: Set the background to be red
