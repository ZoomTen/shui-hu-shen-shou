#!/usr/bin/python
import re

file_list = [ 'banks/bank_%02x.asm' % (i+1) for i in range(0x7f) ]

visual = True

for i in file_list:
	try:
		with open(i, 'r') as fn:
			print(f'{i}: ', end='')
			
			count = 0
			for line in fn:
				dr_match = re.search(r'dr\s+(\$[0-9a-fA-F]+),\s+(\$[0-9a-fA-F]+)', line)
				if dr_match:
					start = int(dr_match.group(1)[1:], 16)
					end = int(dr_match.group(2)[1:], 16)
					count += (end-start)
		
		count_percentage = ((0x4000-count)/0x4000*100)
		
		
		if visual:
			progress_bar = list('[' + ' '*50 + ']')
			for i in range(round(count_percentage/2)):
				progress_bar[i+1] = '█'
			progress_bar = (''.join(progress_bar))
			print('%6.2f%% %s %-5d' % (count_percentage, progress_bar, count))
		else:
			print(' %5d bytes left -> %6.2f%% complete' % (count, count_percentage))
	except Exception as e:
		#print(e)
		pass
