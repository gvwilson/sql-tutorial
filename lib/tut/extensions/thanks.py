"""Handle thanks."""

import shortcodes
import util


@shortcodes.register("thanks")
def thanks(pargs, kwargs, node):
    """Handle [% thanks %] shortcode."""
    util.require(
        (not pargs) and (not kwargs),
        f"Bad 'thanks' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    names = "\n".join([f"<li>{person}</li>" for person in util.thanks()])
    return f"<ul>{names}</ul>"
