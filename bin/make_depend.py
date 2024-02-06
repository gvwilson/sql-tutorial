"""Regenerate SQL dependency description for Make."""

from pathlib import Path
import sys


def main():
    """Main driver."""
    for src in sys.argv[1:]:
        lines = [ln.replace(".read", "").strip() for ln in Path(src).read_text().split("\n") if ln.startswith(".read")]
        if not lines:
            continue
        src = src.replace("src/", "${OUT}/").replace(".sql", ".out")
        lines = [ln.replace("src/", "${SRC}/") for ln in lines]
        print(f"{src}: {' '.join(lines)}")


if __name__ == "__main__":
    main()
