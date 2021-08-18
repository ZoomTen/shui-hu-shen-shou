ASM  := rgbasm
LINK := rgblink
GFX  := rgbgfx
FIX  := rgbfix
MD5  := md5sum -c
PYTHON := python3

# no optimizations
ASMFLAGS := -hL

# Include all labels, including unreferenced and local labels, in the sym/map file if `make` is run with `ALLSYM=1`
ifeq ($(ALLSYM),1)
ASMFLAGS += -E
endif

SCANINC := tools/scan_includes

SOURCES := \
	home.asm \
	main.asm

OBJS := $(SOURCES:%.asm=%.o)

ROM := shui-hu-shen-shou.gbc
MAP := $(ROM:%.gbc=%.map)
SYM := $(ROM:%.gbc=%.sym)

ROM_TITLE := ""

.PHONY: all tools clean compare
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:

all: $(ROM)

tools:
	@$(MAKE) -C tools/

compare: $(ROM)
	$(MD5) rom.md5

clean:
	$(RM) $(ROM) $(MAP) $(SYM) $(OBJS)
	$(MAKE) clean -C tools/

# The dep rules have to be explicit or else missing files won't be reported.
# As a side effect, they're evaluated immediately instead of when the rule is invoked.
# It doesn't look like $(shell) can be deferred so there might not be a better way.
define DEP
$1: $2 $$(shell tools/scan_includes $2)
	$$(ASM) $$(ASMFLAGS) -o $$@ $$<
endef

# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools,$(MAKECMDGOALS)))

$(info $(shell $(MAKE) -C tools))
$(foreach obj, $(OBJS), $(eval $(call DEP,$(obj),$(obj:.o=.asm))))

endif

$(ROM): $(OBJS)
	$(LINK) -n $(SYM) -m $(MAP) -p 0 -o $@ $(OBJS)
	$(FIX) -cv -t $(ROM_TITLE) -l 0x33 -k A7 -m 0x1b -r 2 -p 0 $@

### Catch-all graphics rules

%.2bpp: %.png
	$(GFX) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -o $@ $@)

%.1bpp: %.png
	$(GFX) -d1 -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -d1 -o $@ $@)

%.gbcpal: %.png
	$(GFX) -p $@ $<
