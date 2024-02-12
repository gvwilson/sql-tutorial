"""Count entries of various kinds."""

import re
import sys


PAT = {
    "exercise": [False, re.compile(r'\{%\s+include\s+exercise.md\s+%\}')],
    "topic": [True, re.compile(r'\{%\s+include\s+section.+?\.md\s+class="topic"\s+title="(.+?)"\s+%\}')],
}


def main():
    """Main driver."""
    kind = sys.argv[1]
    titles, pat = PAT[kind]
    text = sys.stdin.read()
    for i, m in enumerate(pat.findall(text)):
        if titles:
            print(f"{i+1:03d}: {m}")
    print(f"Total: {i+1}")


if __name__ == "__main__":
    main()
