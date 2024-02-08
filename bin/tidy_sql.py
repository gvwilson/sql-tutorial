"""Tidy up SQLite-isms for linting."""

import sys

for line in sys.stdin:
    if line.startswith("."):
        print()
    else:
        print(line.rstrip())
