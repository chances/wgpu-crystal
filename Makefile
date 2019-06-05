
default: all

lint:
	bin/ameba
	crystal tool format --check
.PHONY: lint

test:
	crystal spec
.PHONY: test

clean:
	rm examples/headless
	rm examples/*.dwarf
.PHONY: clean

all: vendor-libs shards
.PHONY: all

shards: shard.yml
	shards install
.PHONY: shards

vendor-libs: vendor-submodules vendor-wgpu
.PHONY: vendor-libs

vendor-submodules: vendor/wgpu
.PHONY: vendor-submodules

vendor/wgpu: .gitmodules
	git submodule init
	git submodule update

vendor-wgpu: vendor/wgpu/Cargo.toml
	@cd vendor/wgpu && make lib-native
.PHONY: vendor-wgpu
