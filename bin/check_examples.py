"""Check all SQL files are mention in Makefile and vice versa"""

from pathlib import Path
import re
import sys

def main():
    """Main driver."""
    PAT = re.compile(r"\b(\w+?\.sql)\b")
    root = sys.argv[1]
    unused = set(sys.argv[2:])
    mentioned = set(PAT.findall(Path(sys.argv[1], "Makefile").read_text())) - unused
    found = set(f.name for f in Path(sys.argv[1], "src").glob("*.sql"))
    report("missing", mentioned - found)
    report("unexpected", found - mentioned)


def report(title, values):
    """Report values if any."""
    if values:
        print(f"{title}: {', '.join(sorted(values))}")


if __name__ == "__main__":
    main()
