LIBS = lib/ameba lib/clang

default: all

lint:
	bin/ameba
	crystal tool format --check
.PHONY: lint

test:
	crystal spec
.PHONY: test

clean:
	rm -f examples/headless
	rm -f examples/*.dwarf
	rm -rf lib
	rm src/lib-wgpu.cr
.PHONY: clean

all: vendor-libs shards src/lib-wgpu.cr
.PHONY: all

src/lib-wgpu.cr: lib/clang/bin/c2cr vendor/wgpu vendor/wgpu/ffi/wgpu.h
	@echo "@[Link(ldflags: \"-L#{__DIR__}/../vendor/wgpu/target/debug -lwgpu_native\")]" > src/lib-wgpu.cr
	lib/clang/bin/c2cr -Ivendor/wgpu/ffi wgpu.h --remove-enum-prefix=WGPU >> src/lib-wgpu.cr

lib/clang/bin/c2cr: lib/clang
	@cd lib/clang && shards build --release

shards: ${LIBS}
.PHONY: shards

${LIBS}: shard.yml
	shards install

vendor-libs: vendor-submodules vendor-wgpu
.PHONY: vendor-libs

vendor-submodules: vendor/wgpu
.PHONY: vendor-submodules

vendor/wgpu: .gitmodules
	git submodule init
	git submodule update

vendor-wgpu: vendor/wgpu/target/debug/libwgpu_native.d
.PHONY: vendor-wgpu

vendor/wgpu/target/debug/libwgpu_native.d: vendor/wgpu/Cargo.toml vendor/wgpu/wgpu-native/Cargo.toml
	@cd vendor/wgpu && make lib-native
