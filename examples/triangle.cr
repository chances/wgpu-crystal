require "baked_file_system"

require "./../src/wgpu"
require "./framework.cr"

class Assets
  extend BakedFileSystem
  bake_folder "./assets/triangle"

  def self.shader
    Assets.get("/shader.wgsl").gets_to_end
  end
end

puts "WebGPU Triangle"

Signal::INT.trap { exit }

WGPU.set_log_level WGPU::LogLevel::Warning
WGPU.set_log_callback(->(level : WGPU::LogLevel, message : String) {
  puts "#{level}: #{message}"
})

# TODO: Create a compatible surface to render to?
# surface = LibWGPU::Surface.fromBlah
# adapter = WGPU::Adapter.new(LibWGPU::RequestAdapterOptions.new surface)

adapter = WGPU::Adapter.request
pp adapter.get.info
device = WGPU::Device.request(adapter.get).get

width : UInt64 = 400
height : UInt64 = 300
dimensions = Dimensions.new(width.to_u32, height.to_u32)

shader = WGPU::ShaderModule.from_wgsl(device, Assets.shader)
abort("Could not compile shader", 1) unless shader.is_valid?

output_buffer = device.create_buffer(LibWGPU::BufferDescriptor.new(
  label: nil,
  size: dimensions.size_in_bytes,
  usage: WGPU::BufferUsage::MapRead | WGPU::BufferUsage::CopyDst,
  mapped_at_creation: false
))
texture_extent = LibWGPU::Extent3D.new width: width, height: height, depth: 1

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

pipeline_layout = WGPU::PipelineLayout.empty device
pipeline_label = "Render pipeline"
pipeline = device.create_render_pipeline WGPU::RenderPipelineDescriptor.new(
  label: pipeline_label,
  layout: pipeline_layout,
  vertex: WGPU::VertexState.from(shader, entry_point: "vs_main"),
  primitive: LibWGPU::PrimitiveState.new(
    topology: LibWGPU::PrimitiveTopology::TriangleList,
    strip_index_format: LibWGPU::IndexFormat::Undefined,
    front_face: LibWGPU::FrontFace::CCW,
    cull_mode: LibWGPU::CullMode::None
  ),
  multisample: LibWGPU::MultisampleState.new(
    count: 1,
    mask: ~0,
    alpha_to_coverage_enabled: false,
  ),
  fragment: WGPU::FragmentState.new(
    shader,
    entry_point: "fs_main",
    targets: [
      LibWGPU::ColorTargetState.new(
        format: texture.format,
        blend: WGPU::BlendState.new(
          color: WGPU::BlendComponent::SRC_ONE_DST_ZERO_ADD,
          alpha: WGPU::BlendComponent::SRC_ONE_DST_ZERO_ADD
        ),
        write_mask: LibWGPU::ColorWriteMask::All
      ),
    ],
  ),
  depth_stencil: nil,
)

# Render a triangle
encoder = device.create_command_encoder(LibWGPU::CommandEncoderDescriptor.new)
color_attachment = LibWGPU::RenderPassColorAttachmentDescriptor.new(
  attachment: texture_view,
  resolve_target: LibWGPU::TextureView.null,
  load_op: LibWGPU::LoadOp::Clear,
  store_op: LibWGPU::StoreOp::Store,
  clear_color: WGPU::Colors::GREEN
)
render_pass = encoder.begin_render_pass(LibWGPU::RenderPassDescriptor.new(
  color_attachments: pointerof(color_attachment),
  color_attachment_count: 1,
  depth_stencil_attachment: nil
))

render_pass.pipeline = pipeline
render_pass.draw(3, 1, 0, 0)
render_pass.end_pass

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

device.queue.submit(encoder.finish)

output_buffer.map_read_async(0, dimensions.size_in_bytes.to_u64)

# Poll the device in a blocking manner so that map_read_async resolves.
# In an actual application, `device.poll(...)` should be called in an event loop or on another thread.
device.poll(force_wait: true)

pp output_buffer.status

write_to_png("#{__DIR__}/triangle.png", output_buffer, dimensions)

output_buffer.unmap
