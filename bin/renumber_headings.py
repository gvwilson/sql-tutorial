import re
import sys

NUMBERED = re.compile(r'^##\s+\d+:(.+)$')

with open(sys.argv[1], "r") as reader:
    text = reader.readlines()

num = 1
for i, line in enumerate(text):
    if not (m := NUMBERED.match(line)):
        continue
    text[i] = f"## {num:03d}: {m.group(1).strip()}\n"
    num += 1

with open(sys.argv[1], "w") as writer:
    writer.writelines(text)
