"""Utilities."""

import ark
import markdown
from pathlib import Path
import sys
import yaml


def exercise():
    """Get the next exercise number."""
    return _next_num("_exercise_num")


def fail(msg):
    """Fail unilaterally."""
    print(msg, file=sys.stderr)
    raise AssertionError(msg)


def figure():
    """Get the next figure number."""
    return _next_num("_figure_num")


def glossary():
    """Ensure glossary is loaded and return it."""
    if "_glossary" not in ark.site.config:
        ark.site.config["_glossary"] = _read_info("glossary.yml")
    return ark.site.config["_glossary"]


def links():
    """Ensure links are loaded and return them."""
    if "_links" not in ark.site.config:
        ark.site.config["_links"] = _read_info("links.yml")
    return ark.site.config["_links"]


def link_table():
    """Make a table of links for inclusion in Markdown."""
    if "_link_table" not in ark.site.config:
        ark.site.config["_link_table"] = "\n".join(
            [f"[{entry['key']}]: {entry['url']}" for entry in links()]
        )
    return ark.site.config["_link_table"]


def markdownify(text, strip=True):
    """Convert to Markdown."""
    extensions = ["markdown.extensions.extra", "markdown.extensions.smarty"]
    result = markdown.markdown(text, extensions=extensions)
    if strip and result.startswith("<p>"):
        result = result[3:-4]  # remove trailing '</p>' as well
    return result


def require(cond, msg):
    """Fail if condition untrue."""
    if not cond:
        fail(msg)


def section():
    """Get the next section number."""
    return _next_num("_section_num")


def thanks():
    """Ensure thanks are loaded and return them."""
    if "_thanks" not in ark.site.config:
        ark.site.config["_thanks"] = _read_info("thanks.yml")
    return ark.site.config["_thanks"]


def _next_num(label):
    """Create and return next number in sequence."""
    if label not in ark.site.config:
        ark.site.config[label] = 0
    ark.site.config[label] += 1
    return ark.site.config[label]


def _read_info(filename):
    """Read YAML file from info directory."""
    filepath = Path(ark.site.home(), "info", filename)
    with open(filepath, "r") as reader:
        content = yaml.safe_load(reader) or {}
        return content
