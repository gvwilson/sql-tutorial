"""Create sections and headings."""

import shortcodes
import util


@shortcodes.register("section_break")
def section_break(pargs, kwargs, node):
    """End one section and start another."""
    start = section_start(pargs, kwargs, node)
    end = section_end([], {}, node)
    return f"{end}\n{start}"


@shortcodes.register("section_end")
def section_end(pargs, kwargs, node):
    """Create end of section."""
    return "</section>"


@shortcodes.register("section_start")
def section_start(pargs, kwargs, node):
    """Create start of section."""
    util.require(
        (not pargs) and set(kwargs.keys()).issubset({"class", "title"}),
        f"Bad section_start shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    cls = kwargs.get("class", "")
    num = f"{util.section()}: " if cls == "topic" else ""
    title = "Practice" if cls == "exercise" else kwargs["title"]
    cls = f' class="{cls}"' if cls else ""
    return f'<section markdown="1"{cls}>\n<h2 markdown="1"{cls}>{num}{title}</h2>'
