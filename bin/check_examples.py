"""Check all SQL files are mention in Makefile and vice versa"""

from pathlib import Path
import re
import sys

PAT = re.compile(r"\b(\w+?\.sql)\b")

mentioned = set(PAT.findall(Path(sys.argv[1], "Makefile").read_text()))
found = set(f.name for f in Path(sys.argv[1], "src").glob("*.sql"))
missing = mentioned - found
if missing:
    print(f"missing: {', '.join(sorted(missing))}")
unexpected = found - mentioned
if unexpected:
    print(f"unexpected: {', '.join(sorted(unexpected))}")
