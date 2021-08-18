.PHONY: all clean

CC := gcc
CFLAGS := -O3 -std=c99 -Wall -Wextra -Wno-missing-field-initializers

tools := \
	check_diff.exe

all: $(tools)
	@:

clean:
	rm -f $(tools)

# end binary filename in .exe regardless of operating system
%.exe: %.c
	$(CC) $(CFLAGS) -o $@ $<
