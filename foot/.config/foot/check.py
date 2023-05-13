import json

with open('normal.json') as f:
    normal = json.loads(f.read())

normal = {v:k for k,v in normal.items()}

with open('dawn.json') as  f:
    dawn = json.loads(f.read())

with open('rose-pine-dawn') as f:
    lines = f.readlines()

for i in range(len(lines)):
    orig_line = lines[i]
    if orig_line[0] in ('#', '\n', '['):
        continue
    orig_line = orig_line.strip()
    line, _, comment = orig_line.partition('#')
    if comment:
        comment = '#' + comment
    line = line.strip()
    name, _, hexcodes = line.partition('=')
    hexcodes = hexcodes.split(' ')
    for j in range(len(hexcodes)):
        hexcodes[j] = dawn[normal[hexcodes[j]]]

    hexcodes = ' '.join(hexcodes)
    lines[i] = f'{name}={hexcodes} {comment}\n'

with open('rose-pine-dawn.mod', 'w') as f:
    f.writelines(lines)
