"""Check titles in index."""

import re
import sys


HEADING = re.compile(r'^##\s+(.+)$', re.MULTILINE)


def main():
    """Main driver."""
    text = sys.stdin.read()
    matches = list(HEADING.findall(text))
    prefixes = [title.split(":")[0].strip() for title in matches if ":" in title]
    numbers = [int(n) for n in prefixes if n != 'null']
    wrong = [str(n) for (i, n) in enumerate(numbers) if n != i + 1]
    print(", ".join(wrong))


if __name__ == "__main__":
    main()
