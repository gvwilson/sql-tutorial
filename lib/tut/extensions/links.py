"""Create links table."""

import ark
import shortcodes
import util


@ark.events.register(ark.events.Event.INIT)
def links_append():
    """Add Markdown links to foot of Markdown files."""
    def _visitor(node):
        if node.ext == "md":
            node.text += "\n\n" + util.link_table()

    ark.nodes.root().walk(_visitor)


@shortcodes.register("link_table")
def link_table(pargs, kwargs, node):
    """Create a table of links."""
    util.require(not pargs and not kwargs, f"Bad link_table shortcode in {node.path}")
    links = [ln for ln in util.links() if "title" in ln]
    links.sort(key=lambda x: x["title"])
    links = "\n".join(
        f'<li>{util.markdownify(ln["title"])}: <a href="{ln["url"]}">{ln["url"]}</a></li>'
        for ln in links
    )
    return f"<ul>\n{links}\n</ul>"
