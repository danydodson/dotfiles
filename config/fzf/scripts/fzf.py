#!/usr/bin/env python
import subprocess
command = ['fzf', '--reverse']
p = subprocess.run(command, input=
'''Option1
Option2
Option3''', capture_output=True, text=True)

print(p.stdout)
