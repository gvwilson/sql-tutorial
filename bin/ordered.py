"""Get inclusion filepaths in order."""

import re
import sys

pat = re.compile(r"\{%\s+include\s+(.+?)\s+%\}")

for i, line in enumerate(sys.stdin):
    if m := pat.match(line):
        fields = m.group(1).split(" ", 2)
        match fields[0]:
            case "single.md":
                print(fields[1].replace('file="', "").replace('"', ""))
            case "double.md":
                stem = fields[1].replace('stem="', "").replace('"', "")
                suffixes = (
                    fields[2].replace('suffix="', "").replace('"', "").split(" ", 1)
                )
                print(f"src/{stem}.{suffixes[0]}")
                print(f"out/{stem}.{suffixes[1]}")
            case _:
                pass
