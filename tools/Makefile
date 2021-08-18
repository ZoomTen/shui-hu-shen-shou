.PHONY: all clean

CC := gcc
CFLAGS := -O3 -std=c99 -Wall -Wextra -Wno-missing-field-initializers

tools := \
	scan_includes.exe \
	gfx.exe

all: $(tools)
	@:

clean:
	rm -f $(tools)

gfx: common.h

# end binary filename in .exe regardless of operating system
%.exe: %.c
	$(CC) $(CFLAGS) -o $@ $<
