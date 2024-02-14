"""Handle exercises."""

import shortcodes
import util


@shortcodes.register("exercise")
def exercise(pargs, kwargs, node):
    """Handle [% exercise %] shortcode."""
    util.require(
        (not pargs) and (not kwargs),
        f"Bad 'exercise' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    return f"<strong>Exercise {util.exercise()}</strong>:"
