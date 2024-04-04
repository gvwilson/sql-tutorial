"""Page elements."""

import ark
import ibis

import util

LEFT = "&#x25C5;"
RIGHT = "&#x25BB;"


@ibis.filters.register("is_chapter")
def is_chapter(node):
    """Is this a chapter node (vs. appendix)?"""
    return node.slug and node.slug in ark.site.config["chapters"]


@ibis.filters.register("nav_next")
def nav_next(node):
    """Create next-page link."""
    return _nav_link(node, "next")


@ibis.filters.register("nav_prev")
def nav_prev(node):
    """Create previous-page link."""
    return _nav_link(node, "prev")


def _nav_link(node, kind):
    """Generate previous/next page links."""
    if not node.slug:
        return ""
    contents = ark.site.config["chapters"] + ark.site.config["appendices"]
    try:
        where = contents.index(node.slug)
    except ValueError:
        util.fail(f"unknown slug {node.slug} in {node.path}")
    if kind == "prev":
        if where == 0:
            return ""
        link = f"@root/{contents[where - 1]}/"
        return f'<a href="{link}" class="undecorated" title="previous page">{LEFT}</a>'
    elif kind == "next":
        if where == (len(contents) - 1):
            return ""
        link = f"@root/{contents[where + 1]}/"
        return f'<a href="{link}" class="undecorated" title="next page">{RIGHT}</a>'
    else:
        util.fail(f"Unknown nav link type '{kind}' in {node.path}")
