"""Get inclusion filepaths in order."""

import shortcodes
import sys


@shortcodes.register("double")
def double(pargs, kwargs, context):
    stem = kwargs["stem"]
    suffix = kwargs["suffix"].split()
    context.append(f"src/{stem}.{suffix[0]}")
    context.append(f"out/{stem}.{suffix[1]}")


@shortcodes.register("single")
def single(pargs, kwargs, context):
    context.append(pargs[0])


parser = shortcodes.Parser(ignore_unknown=True)
text = sys.stdin.read()
seen = []
parser.parse(text, context=seen)
for filename in seen:
    print(filename)
