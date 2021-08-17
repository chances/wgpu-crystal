require "http/client"
require "yaml"

{% if flag?(:linux) || flag?(:apple) || flag?(:windows) %}
  puts "Fetching wgpu-native binaries…"
{% else %}
  abort("Unsupported platform for wgpu-crystal!", 1)
{% end %}

project_dir = Path["#{__DIR__}"].parent

abort("Missing native libraries lockfile!", 1) unless File.exists? "./native.lock.yml"
native_lock = File.open("#{project_dir.join "native.lock.yml"}") do |lockfile|
  YAML.parse(lockfile)
end
abort("Missing \"libwgpu_native\" key in ./native.lock.yml", 1) if native_lock["libwgpu_native"]?.nil? || native_lock["libwgpu_native"].as_s?.nil?
wgpu_version = native_lock["libwgpu_native"].as_s
binaries_url = "https://github.com/gfx-rs/wgpu-native/releases/download/v#{wgpu_version}/wgpu-"
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

tmp_zip = "#{Dir.tempdir}/#{Path[binaries_url].basename}"
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
  webgpu_header = archive["webgpu.h"]?
  abort("Could not find webgpu.h!", 1) if webgpu_header.nil?
  webgpu_header.open do |io|
    puts "Deflating webgpu.h…"
    File.write("#{__DIR__}/webgpu.h", io)
  end

  wgpu_header = archive["wgpu.h"]?
  abort("Could not find wgpu.h!", 1) if wgpu_header.nil?
  wgpu_header.open do |io|
    puts "Deflating wgpu.h…"
    File.write("#{__DIR__}/wgpu.h", io)
  end

  wgpu_lib = archive.entries.find(&.filename.starts_with? "libwgpu_native")
  abort("Could not find libwgpu_native DLL!", 1) if wgpu_lib.nil?
  libs_dir = Path["#{__DIR__}"].parent.join "bin/libs"
  wgpu_lib.open do |io|
    puts "Deflating #{wgpu_lib.filename}…"
    Dir.mkdir_p libs_dir
    File.write("#{libs_dir}/#{wgpu_lib.filename}", io, mode: "wb")
  end
end

puts "Done"
