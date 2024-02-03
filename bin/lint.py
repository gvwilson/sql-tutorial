"""Check all SQL files are mention in Makefile and vice versa"""

import argparse
from pathlib import Path
import re
import sys

IN_MAKE = re.compile(r'\b(\w+?\.(sql|py))\b')
MISCFILE = re.compile(r'\{%\s+include\s+miscfile\.md\s+file="src/(.+?)"\s+%\}')
WITHOUT = re.compile(r'\{%\s+include\s+without\.md\s+file="(.+?)"\s+%\}')

def main():
    """Main driver."""
    options = parse_args()

    in_make = find_in_make(options.makefile, options.unused)
    in_page = find_in_page(options.page)
    actual = find_actual(options.source)

    report("in Make but do not exist", in_make - actual)
    report("in page but do not exist", in_page - actual)
    report("exist but not in page or Makefile", (actual - in_page) - in_make)


def find_actual(dirname):
    """Find actual source files."""
    names = {f.name for f in Path(dirname).glob("*.*")}
    names = {n for n in names if not n.endswith("~")}
    return names


def find_in_make(makefile, unused):
    """Find mentions in Makefile."""
    in_make = {m[0] for m in IN_MAKE.findall(Path(makefile).read_text())}
    return in_make - set(unused)


def find_in_page(filename):
    """Find filenames in page."""
    text = Path(filename).read_text()
    return {m for m in MISCFILE.findall(text)} | {m for m in WITHOUT.findall(text)}


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
