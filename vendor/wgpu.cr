require "http/client"

{% if flag?(:linux) || flag?(:apple) || flag?(:windows) %}
  puts "Fetching wgpu-native binaries…"
{% else %}
  abort("Unsupported platform for wgpu-crystal!", 1)
{% end %}

binaries_url = "https://github.com/gfx-rs/wgpu-native/releases/download/v0.7.0/wgpu-"
{% if flag?(:linux) %}
  binaries_url += "linux-"
{% end %}
{% if flag?(:apple) %}
  binaries_url += "macos-"
{% end %}
{% if flag?(:windows) %}
  binaries_url += "windows-"
{% end %}
{% if flag?(:x86_64) %}
  binaries_url += "64"
{% else %}
  binaries_url += "32"
{% end %}
{% if flag?(:release) %}
  binaries_url += "-release.zip"
{% else %}
  binaries_url += "-debug.zip"
{% end %}

tmp_zip = "#{Dir.tempdir}/#{{Path[binaries_url].basename}}"
unless File.exists? tmp_zip
  puts "Downloading " + binaries_url

  response = HTTP::Client.get binaries_url
  # Follow redirect
  if (response.status_code == 302 && !response.headers["location"].nil?)
    response = HTTP::Client.get response.headers["location"]
  end
  if (response.status_code != 200)
    puts response.status_code
    exit(1)
  end

  File.write(tmp_zip, response.body)
end

require "compress/zip"
Compress::Zip::File.open(tmp_zip) do |archive|
  wgpu_header = archive["wgpu.h"]?
  if wgpu_header.nil?
    abort("Could not find wgpu.h!", 1)
  end
  wgpu_header.open do |io|
    puts "Deflating wgpu.h…"
    File.write("#{__DIR__}/wgpu.h", io)
  end

  wgpu_lib = archive.entries.find { |entry| entry.filename.starts_with? "libwgpu_native" }
  if wgpu_lib.nil?
    abort("Could not find libwgpu_native DLL!", 1)
  end
  libs_dir = Path["#{__DIR__}"].parent.join "bin/libs"
  wgpu_lib.open do |io|
    puts "Deflating #{wgpu_lib.filename}…"
    Dir.mkdir_p libs_dir
    IO.copy(io, File.open("#{libs_dir}/#{wgpu_lib.filename}", "wb"))
  end
end

puts "Done."
