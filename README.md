# wgpu-crystal

[![wgpu.cr v0.9.2](https://img.shields.io/badge/shards-v0.9.2-important)](https://shards.info/github/chances/wgpu-crystal)
[![wgpu.cr CI](https://github.com/chances/wgpu-crystal/actions/workflows/ci.yml/badge.svg)](https://github.com/chances/wgpu-crystal/actions/workflows/ci.yml)
[![wgpu.cr license: MIT](https://img.shields.io/badge/license-MIT-informational)](https://github.com/chances/wgpu-crystal/blob/master/LICENSE)

Bindings to [gfx-rs/wgpu-native](https://github.com/gfx-rs/wgpu-native) for the [Crystal](https://crystal-lang.org/) programming language.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     wgpu:
      github: chances/wgpu-crystal
   ```

2. Run `shards install`

## Usage

```crystal
require "wgpu"

# TODO: Write usage instructions here
```

See the [wgpu-native Usage instructions](https://github.com/gfx-rs/wgpu-native#usage).

## Development

TODO: Write development instructions here

### Running examples

#### Headless

`make example-headless`

#### Headless Triangle

`make example-triangle`

#### Windowed Triangle

TODO: Add a windowed example

Ensure [glfw3](https://formulae.brew.sh/formula/glfw) is installed.

`make example-glfw-triangle`

## Contributing

1. Fork it ([https://github.com/chances/wgpu-crystal/fork](https://github.com/chances/wgpu-crystal/fork))
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chance Snow](https://github.com/chances) - creator and maintainer
