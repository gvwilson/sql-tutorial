"""Handle figures."""

import shortcodes
import util


@shortcodes.register("figure")
def link_table(pargs, kwargs, node):
    """Create a table of links."""
    util.require(
        (not pargs) and (set(kwargs.keys()) == {"file", "title", "alt"}),
        f"Bad 'figure' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    filename = kwargs["file"]
    title = kwargs["title"]
    alt = kwargs["alt"]
    figure_id = util.figure(node.slug)
    lines = [
        f'<figure id="figure_{figure_id}">',
        f'<img src="{filename}" alt="{alt}"/>',
        f"<figcaption>Figure {figure_id}: {title}</figcaption>",
        "</figure>",
    ]
    return "\n".join(lines)
