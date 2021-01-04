# "detect" project top directory
TOP := $(CURDIR)

# select build directory
BUILD := $(TOP)/build

# Build with up to 32 (or number of cores) parallel processes
# $(grep -c ^processor /proc/cpuinfo) also works if no nproc
# Is there better way of doing this?
#MAKE := $(MAKE) -j$(shell (nproc; echo 32) | sort -n | head -n 1)

# In case you have several cmakes installed in parallel (2.x, 3.x)
CMAKE := cmake


# select default target, print help for now
all: help
.PHONY: all


help:
	@echo "Available make targets:"
	@echo "    d,  debug:      debug build"
	@echo "    dc, debugc:     debug build with clang"
	@echo "    r,  release:    release build"
	@echo "    rc, releasec:   release build with clang"
	@echo
	@echo "    run:            run the binary"
	@echo
	@echo "    c,  clean:      clean the build tree"
	@echo "    cc, distclean:  remove the build directory"
	@echo
	@echo "NB: 'make VERBOSE=1 debug' for verbose build"
.PHONY: help


# Prebuild commands - make the "build" directory
prebuild:
	test -d $(BUILD) || mkdir -p $(BUILD)
.PHONY: prebuild


debug: prebuild
	cd $(BUILD) && $(CMAKE) -D CMAKE_BUILD_TYPE=Debug $(TOP) && $(MAKE)
.PHONY: debug
d: debug


debugc: prebuild
	cd $(BUILD) && CC=clang CXX=clang++ $(CMAKE) -D CMAKE_BUILD_TYPE=Debug $(TOP) && $(MAKE)
.PHONY: debugc
dc: debugc


release: prebuild
	cd $(BUILD) && $(CMAKE) -D CMAKE_BUILD_TYPE=Release $(TOP) && $(MAKE)
.PHONY: release
r: release


releasec: prebuild
	cd $(BUILD) && CC=clang CXX=clang++ $(CMAKE) -D CMAKE_BUILD_TYPE=Release $(TOP) && $(MAKE)
.PHONY: releasec
rc: releasec


run:
	$(BUILD)/test-cmake
.PHONY: run


clean:
	-(cd $(BUILD) && $(MAKE) clean)
.PHONY: clean
c: clean


distclean:
	-rm -rf $(BUILD)
.PHONY: distclean
cc: distclean
