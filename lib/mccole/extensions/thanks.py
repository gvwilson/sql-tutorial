"""Handle thanks."""

import ark
from pathlib import Path
import shortcodes
import yaml

import util


@shortcodes.register("thanks")
def thanks(pargs, kwargs, node):
    """Handle [% thanks %] shortcode."""
    util.require(
        (not pargs) and (not kwargs),
        f"Bad 'thanks' in {node.path}: '{pargs}' and '{kwargs}'",
    )
    filepath = Path(ark.site.home(), "info", "thanks.yml")
    names = yaml.safe_load(filepath.read_text()) or []
    names = "\n".join([f"<li>{person}</li>" for person in names])
    return f'<ul class="thanks">{names}</ul>'
