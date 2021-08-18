# Style guide

## ASM

* Labels are **not indented**
* Code is indented with **one tab**.
* Each instruction argument is separated by **one space each**
* Spaces around math expressions
* `EQU` is capitalized
* < 80 characters when possible
* `hli` / `hld`, not `hl+` / `hl-`
* Use `-1` in place of `$ff` when used as a list terminator
* One space before main labels and after a `ret` or `jp` / `jr`

* Spaces after semicolons
* Comments above code, not below/inline


* SECTION, INCLUDE, MACRO, etc. directives should be uppercase
* INCLUDEs can be indented for readability
* Before every SECTION there should be two spaces
* Data macros should be lower_snake_case, except for RGB
* When in doubt, prefer lowercase

## Symbols

* WRAM symbols are PascalCase and begin with a lowercase 'w'.
* HRAM symbols are PascalCase and begin with a lowercase 'h'.
* Constants are UPPER_SNAKE_CASE
* Code labels are PascalCase
* Local symbols (single colon) whenever possible (global symbols use two)
* Replace unused labels with comments
* Relative (dots at the beginning) jumps should use lower_snake_case, without a colon after it
* Atomic code chunks should be relative, WITH a single colon.

### Documented

Labels which describe the exact purpose of a symbol, e.g. `DisplayLogo` for a piece of code that displays a logo on the screen.

Map names should correspond with its constant name by directly converting UPPER_SNAKE_CASE to PascalCase and vice versa.

Maps belonging to an area (such as indoor maps) should be formatted like so: `ForestP1`, `ForestP2` or `House1F`, `House2F`

For data, keywords that describe what part of the symbol goes **after** it (preceded with an underscore), e.g. `Logo_GFX`, `Logo_Palette`. See section 'Keywords' below.

Duplicates directly go **after** the keyword: `Hometown_Layout1`, `Hometown_Layout2`

Non-English games: Constants/label names should be direct translations if possible.

### Partially documented

How it is used is known but purpose still unknown, therefore still uses an address in the label.

This takes the form of `Keyword_BB_AAAA` where BB = bank and AA = address, all 2-digit hexadecimal numbers.

For bank 0, the format of `Keyword_AAAA` should be used.

### Undocumented symbols

Both purpose and how it's used is still unknown / not ripped or disassembled yet.

Keywords `Func`, `asm` and `unk` should be used.

See section 'Partially documented' for usage

Undocumented WRAM symbols e.g. `wc000`, `wc001`, etc.

Undocumented HRAM symbols e.g. `hFF80`, `hFF81`, etc.

Use `utils/check_symbols.py` to help debug shifting issues.

### Keywords

* `Layout` - Game map layout consisting of blocks
* `Blocks` - 32x32 map fragments consisting of metatiles
* `Metatiles` - 16x16 map fragments consisting of graphics tiles
* `Collision` - Game map collision data
* `MapAttributes` - Visual attributes of a game map, defining all of the above
* `Header` - Game map headers, determining warp points and event pointers
* `ObjectEvents` - Interactible events leading to scripts
* `MapEvents` - Signposts and warps


* `Script` - Game script
* `Text` - Dialog text
* `String` - Line of text to be printed immediately


* `GFX` - Graphics
* `Pic` - Compressed graphics
* `BGMap` - Direct background map
* `WinMap` - Same as `BGMap` but with the intent of displaying it in the window layer
* `AttrMap` - GBC attributes map
* `Sprite` - Sprite definition data
* `Palette` - Game Boy Color palettes


* `Pointers` - For lists of data pointers/unknown pointers
* `Jumptable` - Pointers to code fragments
* `Sprites` - Sprite list
