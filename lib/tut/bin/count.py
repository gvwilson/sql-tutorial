"""Get section headings and numbers in order."""

import shortcodes
import sys


@shortcodes.register("double")
def double(pargs, kwargs, context):
    context["inclusion"] += 1


@shortcodes.register("section_break")
def section_break(pargs, kwargs, context):
    section_start(pargs, kwargs, context)


@shortcodes.register("section_end")
def section_break(pargs, kwargs, context):
    pass


@shortcodes.register("section_start")
def section_start(pargs, kwargs, context):
    context[kwargs["class"]] += 1


@shortcodes.register("single")
def single(pargs, kwargs, context):
    context["inclusion"] += 1


parser = shortcodes.Parser(ignore_unknown=True)
text = sys.stdin.read()
context = {
    "aside": 0,
    "exercise": 0,
    "inclusion": 0,
    "topic": 0,
}
parser.parse(text, context=context)
for key, count in context.items():
    print(f"{key}: {count}")
