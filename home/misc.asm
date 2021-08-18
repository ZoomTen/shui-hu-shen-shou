Start:
	ldh [wff91], a
	ld sp, $dfff
	xor a
	ldh [rSCX], a
	ldh [rSCY], a
	di
	ld a, 0
	ldh [rLCDC], a
	ld a, $e4
	ldh [rBGP], a
	ld a, $1f
	ld [wdce7], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ld a, $40
	ldh [rSTAT], a
	ld a, $8f
	ldh [rLYC], a
	ld a, 0
	ldh [rIF], a
	ld a, 3
	ldh [hFFFF], a
	jp ContinueInit

AlternateHeader::
	dr $17f, $200

ContinueInit:
	call Func_22e3
	call Func_22d4
	ld hl, $0bf1
	ld a, l
	ld [wd9e0], a
	ld a, h
	ld [wd9e1], a
	ei
	ld a, 2
	ld [wd091], a
	call Func_20f8
	call Func_2679
	ld a, $1c
	ldh [wff9b], a
	ld a, 0
	ldh [wff9c], a
	ld [wd0ff], a
	ld [wd0df], a
	ld [wd0ef], a
	ld a, 0
	ld [wffba], a
	call Func_113a
	ld a, $16
	ld [wd0fa], a
	ld bc, wcab0
	xor a
	ldh [wffc4], a
	call Func_06fc
	ld de, .GameMode_Pointers
	ld a, [wd0fa]
	ld l, a
	ld h, 0
	add hl, hl
	add l
	ld l, a
	add hl, de
	ld a, [hli]
	rst Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.GameMode_Pointers:
	dbw Func_05_41d9 ; 00 - Overworld
	dbw Func_23_4000 ; 01 - Catching food minigame
	dbw Func_3c_4117 ; 02 - New game / continue menu
	dbw Func_3c_438b ; 03 - Game Over
	dbw Func_48_4000 ; 04 - Quiz minigame
	dbw Func_51_4000 ; 05 - Betting minigame
	dbw Func_52_4000 ; 06 - Flying minigame
	dbw Func_53_4000 ; 07 - Drinking minigame
	dbw Func_54_4000 ; 08 - Map
	dbw Func_57_4526 ; 09 - Title card 1
	dbw Func_57_4372 ; 0a - Title card 2
	dbw Func_57_42c7 ; 0b - Title card 3
	dbw Func_57_4223 ; 0c - Text cutscene
	dbw Func_5d_490f ; 0d - The End -> Credits
	dbw Func_5d_43d7 ; 0e - Vast Fame The End
	dbw Func_5d_4a25 ; 0f - Credits
	dbw Func_5e_402c ; 10 - Intro part 1
	dbw Func_5f_402c ; 11 - Intro part 2
	dbw Func_60_402c ; 12 - Intro part 3
	dbw Func_61_402c ; 13 - Intro part 4
	dbw Func_62_402c ; 14 - Intro part 5 -> Title screen
	dbw Func_62_402f ; 15 - Title screen
	dbw Func_64_4000 ; 16 - Vast Fame splash screen

Func_029c:
.loop
	ldh a, [rLCDC]
	and a
	ret z
	ldh a, [wff90]
	and a
	jr z, .loop
	xor a
	ldh [wff90], a
	ret

Func_02a9:
	ld a, [w7fff]
	push af
	ld a, [wd9f0]
	rst Bankswitch
	call Func_02b7
	pop af
	rst Bankswitch
	ret

Func_02b7:
	ld a, [hli]
	push bc
	ld c, a
.loop
	ldh a, [rSTAT]
	and 3
	jr nz, .loop
	ld a, c
	ld [de], a
	inc de
	pop bc
	dec bc
	ld a, c
	or b
	jr nz, Func_02b7
	ret

; TODO
	dr $2ca, $230e

Func_230e::
	dr $230e, $237f

Func_237f::
	dr $237f, $26c4
