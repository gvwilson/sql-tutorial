"""Create a count of SQL features used in examples."""

import argparse
from collections import Counter
from pathlib import Path
import re
import sqlparse
import sys


CHUNK_RE = re.compile(r"^```sql\s*(.+?)^```", re.DOTALL + re.MULTILINE)


def main():
    """Main driver."""
    options = parse_args()
    counter = Counter()
    for sql in get_sql(options):
        analyze(counter, sql)
    report(options, counter)


def analyze(counter, sql):
    """Analyze statements in a single chunk of SQL."""
    wanted = {
        sqlparse.tokens.Keyword,
        sqlparse.tokens.Keyword.Order,
        sqlparse.tokens.CTE,
        sqlparse.tokens.DDL,
        sqlparse.tokens.DML,
    }
    tokens = sqlparse.parse(sql)[0]
    tokens = list(tokens.flatten())
    for token in sqlparse.parse(sql)[0].flatten():
        if token.ttype in wanted:
            counter[token.value] += 1


def get_sql(options):
    """Get chunks of SQL to process."""
    if not options.files:
        return [sys.stdin.read()]
    return [Path(f).read_text() for f in options.files]


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--files", nargs="+", help="filenames")
    parser.add_argument("--missing", type=str, help="full keyword file")
    parser.add_argument(
        "--report", choices=["alpha", "freq"], default="freq", help="what to report"
    )
    return parser.parse_args()


def report(options, counter):
    """Report results."""
    if options.missing:
        actual = set(counter.keys())
        expected = {
            x.strip() for x in Path(options.missing).read_text().split("\n")
        } - {""}
        for name in sorted(expected - actual):
            print(name)

    elif options.report == "alpha":
        for name, count in sorted(counter.items(), key=lambda x: x[0]):
            print(f"{count:4d}: {name}")

    elif options.report == "freq":
        for name, count in sorted(counter.items(), key=lambda x: x[1], reverse=True):
            print(f"{count:4d}: {name}")

    else:
        print(f"Unknown reporting option {options.report}", file=sys.stderr)


if __name__ == "__main__":
    main()
