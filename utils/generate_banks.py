#!/usr/bin/env python3

'''
Generates blank bank files and a blank main.asm to go along with it
'''

import os
import sys

if len(sys.argv) < 3:
	print('generate_banks.py [num. banks (decimal)] [folder]')
	exit(1)

print('This will replace main.asm and everything in banks/. Are you sure [y/N]? ', end='')

if input().lower() == 'y':
	pass
else:
	print('exited')
	exit(0)

banks = int(sys.argv[1])
folder = sys.argv[2]

for i in range(banks):
	with open(os.path.join(folder, 'bank_%02x.asm' % (i+1)), 'w') as asm:
		print('Unk_%02x_4000:' % (i+1), file=asm)
		print('\tdr $%x, $%x' % (0x4000*(i+1), 0x4000*(i+2)-1), file=asm)
		print('\n\nSECTION "banknum%02x", ROMX[$7fff], BANK[$%02x]' % (i+1, i+1), file=asm)
		print('\tdb $%02x' % (i+1), end='', file=asm)

with open('main.asm', 'w') as main:
	for i in range(banks):
		print('\n\n\nSECTION "bank%02x", ROMX, BANK[$%02x]' % (i+1, i+1), file=main)
		print('\nINCLUDE "banks/bank_%02x.asm"' % (i+1), end='', file=main)
