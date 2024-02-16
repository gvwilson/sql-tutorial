"""Check all SQL files are mention in Makefile and vice versa"""

import argparse
from pathlib import Path
import re
import shortcodes
import yaml


CROSSREF = re.compile(r"\]\(\#(.+?)\)", re.DOTALL)
MAKE_INC = re.compile(r"\$\{(OUT|SRC)\}/(\w+?\.(sql|out|py))\b")

@shortcodes.register("double")
def double(pargs, kwargs, context):
    stem = kwargs["stem"]
    suffix = kwargs["suffix"].split()
    context["inclusion"].add(f"{context['src']}/{stem}.{suffix[0]}")
    context["inclusion"].add(f"{context['out']}/{stem}.{suffix[1]}")


@shortcodes.register("single")
def single(pargs, kwargs, context):
    context["inclusion"].add(pargs[0])


@shortcodes.register("g")
def glossref(pargs, kwargs, context):
    context["glossref"].add(str(Path(pargs[0]).name))


def main():
    """Main driver."""
    options = parse_args()
    parser = shortcodes.Parser(ignore_unknown=True)
    context = {
        "glossref": set(),
        "inclusion": set(),
        "out": options.output,
        "src": options.source,
    }
    parser.parse(Path(options.page).read_text(), context)
    do_inclusions(options, context["inclusion"])
    do_glossary(options, context["glossref"])


def do_glossary(options, used):
    """Handle glossary checks."""
    with open(options.glossary, "r") as reader:
        glossary = yaml.load(reader, Loader=yaml.FullLoader)
        known = set()
        for entry in glossary:
            known.add(entry["key"])
            for m in CROSSREF.findall(entry[options.lang]["def"]):
                used.add(m)
    report("unknown glossary keys", used - known)
    report("unused glossary keys", known - used)


def do_inclusions(options, page_inc):
    """Handle inclusion checking."""

    make_inc = find_make_inc(options.makefile, options.unused)
    actual = find_actual(options.source, options.output)

    report("in Make but do not exist", make_inc - actual)
    report("in page but do not exist", page_inc - actual)
    unused = (actual - make_inc) - page_inc
    report("exist but not in page or Makefile", unused)


def find_actual(src, out):
    """Find actual source files."""
    names = set()
    for dirname in (src, out):
        names |= {str(Path(dirname, f.name)) for f in Path(dirname).glob("*.*")}
    names = {n for n in names if not n.endswith("~")}
    return names


def find_make_inc(makefile, unused):
    """Find mentions in Makefile."""
    make_inc = {f"{m[0].lower()}/{m[1]}" for m in MAKE_INC.findall(Path(makefile).read_text())}
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
    parser.add_argument(
        "--lang", type=str, required=True, help="language"
    )
    parser.add_argument(
        "--output", type=str, required=True, help="path to output directory"
    )
    parser.add_argument(
        "--page", type=str, required=True, help="path to tutorial source page"
    )
    parser.add_argument(
        "--source", type=str, required=True, help="path to source directory"
    )
    parser.add_argument(
        "--unused", type=str, nargs="*", help="source files not used directly"
    )
    return parser.parse_args()


def report(title, values):
    """Report values if any."""
    if values:
        print(title)
        for v in sorted(values):
            print(f"- {v}")


if __name__ == "__main__":
    main()
