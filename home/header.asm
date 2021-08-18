; rst vectors (called through the rst instruction)


SECTION "rst08", ROM0[$8]

_hl_::
	jp hl


SECTION "rst20", ROM0[$20]

Bankswitch::
	ld [wd08f], a
	ld [rROMB0], a
	ret


SECTION "rst30", ROM0[$30]

FarCall::
; Call b:hl.
	ld a, [_BANKNUM]
	push af
	ld a, b
	rst Bankswitch
	rst _hl_
	pop af
; SECTION "rst38", ROM0[$0038]
	rst Bankswitch
	ret


; Game Boy hardware interrupts


SECTION "vblank", ROM0[$0040]
	jp Func_230e
	ret


SECTION "lcd", ROM0[$0048]
	jp Func_237f
	ret


SECTION "Header", ROM0[$0100]

Entry::
	jp Start

; rgbfix patches over most of the header
; however this game is being weird

; non-ASCII license code
	ds $144 - @, 0
	db $01, $07

; destination code
	ds $14a - @, 0
	db $0f

; leave out the rest
	ds $150 - @, 0
