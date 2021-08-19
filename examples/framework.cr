require "stumpy_png"
include StumpyPNG

require "./../src/wgpu"

BYTES_PER_PIXEL = sizeof(UInt32)

# https://github.com/rukai/wgpu-rs/blob/f6123e4fe89f74754093c07b476099623b76dd08/examples/capture/main.rs#L53
record Dimensions, width : UInt32, height : UInt32 do
  def unpadded_bytes_per_row
    width * BYTES_PER_PIXEL
  end

  def padded_bytes_per_row
    align = WGPU::COPY_BYTES_PER_ROW_ALIGNMENT
    padded_bytes_per_row_padding = (align - unpadded_bytes_per_row % align) % align
    unpadded_bytes_per_row + padded_bytes_per_row_padding
  end

  def size_in_bytes
    padded_bytes_per_row * height
  end
end

def write_to_png(file : String, buffer : WGPU::Buffer, dimensions : Dimensions)
  canvas = Canvas.new(dimensions.width.to_i32, dimensions.height.to_i32)

  if buffer.is_mapped?
    padded_bytes_per_row = dimensions.padded_bytes_per_row
    unpadded_bytes_per_row = dimensions.unpadded_bytes_per_row
    padded_buffer = buffer.get_mapped_range(0, dimensions.size_in_bytes.to_u64)
    rows = padded_buffer.in_groups_of(padded_bytes_per_row, 0).map do |chunk|
      chunk[0..unpadded_bytes_per_row].in_groups_of(4, 0)
    end

    rows.each_index do |y|
      rows[y].each_index do |x|
        pixel = rows[y][x].map(&.to_u16)
        canvas[x, y] = RGBA.from_rgba_n(pixel, 8) unless x >= dimensions.width
      end
    end

    StumpyPNG.write(canvas, file)
  end
end
