#!/usr/bin/env python

import argparse
import re
import sys
import sqlite3
import subprocess


ENCODING = "utf-8"
SQLITE = "sqlite3"

def main():
    """Regenerate Markdown output from SQL and comments."""
    args = parse_args()
    chunks = read_chunks(args.infile)
    chunks = [process(args, kind, body) for (kind, body) in chunks]
    save_page(args.outfile, "\n\n".join(chunks))


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--dbfile", type=str, help="database file")
    parser.add_argument("--infile", type=str, help="input file")
    parser.add_argument("--outfile", type=str, help="output file")
    return parser.parse_args()


def process(args, kind, body):
    """Process a block of text."""
    handlers = {
        "sql": process_sql,
        "md": process_md,
    }
    return handlers[kind](args, body)


def process_md(args, text):
    """Reformat text."""
    return text.replace("\n ", "\n").strip()


def process_sql(args, text):
    """Run a SQL command and return its output."""
    cmd = [SQLITE, args.dbfile]
    p = subprocess.run(cmd, input=text.encode(ENCODING), capture_output=True)
    result = p.stdout.decode(ENCODING)
    code = f"```sql\n{text.rstrip()}\n```\n"
    output = f"```text\n{result.rstrip()}\n```" if result.strip() else ""
    return f"{code}{output}"


def read_chunks(infile):
    """Read input file as chunks."""
    if infile:
        with open(infile, "r") as reader:
            text = reader.readlines()
    else:
        text = sys.stdin.readlines()

    kind = "sql"
    result = []
    current = []
    for line in text:
        line = line.rstrip()
        if (kind == "sql") and line.startswith("/*"):
            result.append((kind, ("\n".join(current)).strip()))
            kind, current = "md", []
        elif (kind == "md") and line.startswith("*/"):
            result.append((kind, ("\n".join(current)).strip()))
            kind, current = "sql", []
        else:
            current.append(line)

    result.append((kind, ("\n".join(current)).strip()))
    return [r for r in result if r[1]]


def save_page(outfile, text):
    """Save generated result."""
    permalink = outfile.split("/")[-1].split(".")[0]
    header = f'---\npermalink: "/{permalink}/"\n---\n'
    if outfile:
        with open(outfile, "w") as writer:
            writer.write(header)
            writer.write(text)
    else:
        writer.write(header)
        writer.write(text)


if __name__ == "__main__":
    main()
