"""Check all SQL files are mention in Makefile and vice versa"""

import argparse
from pathlib import Path
import re
import sys

FILENAME = re.compile(r"\b(\w+?\.(sql|py))\b")


def main():
    """Main driver."""
    options = parse_args()
    unused = set(options.unused)
    mentioned = {m[0] for m in FILENAME.findall(Path(options.makefile).read_text())} - unused
    found = {f.name for f in Path(options.source).glob("*.sql")} | {f.name for f in Path(options.source).glob("*.py")}
    report("missing", mentioned - found)
    report("unexpected", found - mentioned)


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--makefile", type=str, required=True, help="path to Makefile")
    parser.add_argument("--page", type=str, required=True, help="path to tutorial source page")
    parser.add_argument("--source", type=str, required=True, help="path to source directory")
    parser.add_argument("--unused", type=str, nargs="+", help="source files not used directly")
    return parser.parse_args()


def report(title, values):
    """Report values if any."""
    if values:
        print(f"{title}: {', '.join(sorted(values))}")


if __name__ == "__main__":
    main()
