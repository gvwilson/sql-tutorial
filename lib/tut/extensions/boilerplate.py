"""Create links table."""

import ark
from pathlib import Path
import shortcodes
import util


@shortcodes.register("boilerplate")
def boilerplate(pargs, kwargs, node):
    """Include a file from the root directory"""
    util.require(
        len(pargs) == 1 and not kwargs, f"Bad 'boilerplate' shortcode in {node.path}"
    )
    text = Path(ark.site.home(), pargs[0]).read_text()
    if text.startswith("#"):
        text = text.split("\n", 1)[1]
    return text
