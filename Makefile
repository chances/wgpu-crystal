CWD := $(shell pwd)
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

src/lib-wgpu.cr: lib/clang/bin/c2cr vendor/wgpu.h
	@echo "@[Link(ldflags: \"-L#{__DIR__}/../bin/libs -lwgpu_native\")]" > src/lib-wgpu.cr
	lib/clang/bin/c2cr -Ivendor wgpu.h --remove-enum-prefix=WGPU >> src/lib-wgpu.cr

lib/clang/bin/c2cr: lib/clang
	@cd lib/clang && shards build --release

shards: ${LIBS}
.PHONY: shards

${LIBS}: shard.yml
	shards install

vendor-libs: vendor-wgpu
.PHONY: vendor-libs

vendor-wgpu: vendor/wgpu.h
.PHONY: vendor-wgpu

# TODO: Execute with --release for release builds
vendor/wgpu.h:
	crystal vendor/wgpu.cr

example-headless:
	env LD_LIBRARY_PATH=${CWD}/bin/libs crystal examples/headless.cr
.PHONY: example-headless
