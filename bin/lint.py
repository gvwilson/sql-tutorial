"""Check all SQL files are mention in Makefile and vice versa"""

import argparse
from pathlib import Path
import re
import sys
import yaml

GLOSS_REF = re.compile(r'<span\s+data-gloss="(.+?)">')
MAKE_INC = re.compile(r'\b(\w+?\.(sql|py))\b')
SINGLE_INC = re.compile(r'\{%\s+include\s+single\.md\s+file=".+?/(.+?)"\s+%\}')
DOUBLE_INC = re.compile(r'\{%\s+include\s+double\.md\s+stem="(.+?)"\s+suffix="(.+?)"\s+%\}')

def main():
    """Main driver."""
    options = parse_args()

    do_inclusions(options)
    do_glossary(options)


def do_glossary(options):
    """Handle glossary checks."""
    used = {ref for ref in GLOSS_REF.findall(Path(options.page).read_text())}
    with open(options.glossary, "r") as reader:
        known = {entry["key"] for entry in yaml.load(reader, Loader=yaml.FullLoader)}
    report("unknown glossary keys", used - known)
    report("unused glossary keys", known - used)


def do_inclusions(options):
    """Handle inclusion checking."""

    make_inc = find_make_inc(options.makefile, options.unused)
    page_inc = find_page_inc(options.page)
    actual = find_actual(options.source, options.output)

    report("in Make but do not exist", make_inc - actual)
    report("in page but do not exist", page_inc - actual)
    unused = (actual - make_inc) - page_inc
    report("exist but not in page or Makefile", unused)


def find_actual(src, out):
    """Find actual source files."""
    names = set()
    for dirname in (src, out):
        names |= {f.name for f in Path(dirname).glob("*.*")}
    names = {n for n in names if not n.endswith("~")}
    return names


def find_make_inc(makefile, unused):
    """Find mentions in Makefile."""
    make_inc = {m[0] for m in MAKE_INC.findall(Path(makefile).read_text())}
    return make_inc - set(unused)


def find_page_inc(filename):
    """Find filenames in page."""
    text = Path(filename).read_text()
    result = {m for m in SINGLE_INC.findall(text)}
    for m in DOUBLE_INC.findall(text):
        for suffix in m[1].split():
            result.add(f"{m[0]}.{suffix}")
    return result


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--glossary", type=str, required=True, help="path to glossary")
    parser.add_argument("--makefile", type=str, required=True, help="path to Makefile")
    parser.add_argument("--output", type=str, required=True, help="path to output directory")
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
