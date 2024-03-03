"""Handle TODO notes."""

import shortcodes
import util


@shortcodes.register("todo")
def toto(pargs, kwargs, node):
    """Handle inclusion of multiple files."""
    util.require(
        (len(pargs) == 1) and (not kwargs),
        f"Bad 'todo' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    return f'<p class="center"><span class="todo">TODO: {util.markdownify(pargs[0])}</span></p>'
