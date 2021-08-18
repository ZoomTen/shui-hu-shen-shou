#!/usr/bin/python

'''
Check a certain amount of free space in a binary.
'''

from argparse import ArgumentParser, FileType
import re
from lib.gbtool import offset2addr

ap = ArgumentParser(
	description='Check a certain amount of free space in a ROM',
)

ap.add_argument(
	'baserom',
	type=FileType('rb')
)
ap.add_argument(
	'bytes',
	type=int
)

args = ap.parse_args()

rom = args.baserom.read()

# todo: set free space byte
for i in re.finditer(b'\x00{%d}' % args.bytes, rom):
	print( '$%02x bytes of free space found at $%x [%02x:%04x]' % (
			args.bytes,
			i.span()[0],
			*offset2addr(i.span()[0])
		)
	)
