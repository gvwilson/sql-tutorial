"""Page elements."""

import ark
import ibis

import util


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
        return f'<a href="@root/{contents[where - 1]}/">&lArr;</a>'
    elif kind == "next":
        if where == (len(contents) - 1):
            return ""
        return f'<a href="@root/{contents[where + 1]}/">&rArr;</a>'
    else:
        util.fail(f"Unknown nav link type '{kind}' in {node.path}")
