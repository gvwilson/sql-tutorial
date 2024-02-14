"""Initialization required by template."""

import ark
from datetime import datetime


@ark.events.register(ark.events.Event.INIT)
def init_date():
    """Add the date to the site configuration object."""
    ark.site.config["build_date"] = datetime.utcnow()


@ark.filters.register(ark.filters.Filter.LOAD_NODE_FILE)
def filter_files(value, filepath):
    """Only process HTML and Markdown files."""
    result = filepath.suffix in {".html", ".md"}
    return result
