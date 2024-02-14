"""Handle configuration values."""

import ark
import shortcodes
import util


@shortcodes.register("config")
def config(pargs, kwargs, node):
    """Handle [% config "key" %] shortcode."""
    util.require(
        (len(pargs) == 1) and (not kwargs),
        f"Bad 'config' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    util.require(
        pargs[0] in ark.site.config,
        f"Unknown configuration key '{pargs[0]}' in 'config' shortcode in {node.path}",
    )
    return ark.site.config[pargs[0]]
