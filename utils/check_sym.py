#!/usr/bin/python3

import re
import sys

fn = sys.argv[1]

all_matches, no_matches = (0, 0)

def check_sym(x):
	global all_matches
	global no_matches
	all_matches += 1
	rendered = x.group(1)
	claimed = x.group(2)
	
	if rendered == claimed:
		print(f'claimed: {claimed} matched')
	else:
		no_matches += 1
		print(f'claimed: {claimed} -- DOES NOT MATCH! -- actual: {rendered}')
	return None

with open(fn, "r") as f_:
	line = f_.readline()
	while line:
		re.sub('0[01]:([0-9a-f]+) w([0-9a-f]+)', check_sym, line)
		line = f_.readline()
	
	if no_matches == 0:
		print('---- ALL MATCHING! -----')
	else:
		print('-- %d SYMBOLS DOES NOT MATCH (%.1f%% matching) --' %
			(
				no_matches,
				((all_matches-no_matches) / all_matches) * 100
			)
		)
