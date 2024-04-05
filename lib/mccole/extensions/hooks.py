"""Various hooks for processing files."""

import ark

EXCLUSIONS = {
    "__pycache__",
}


@ark.filters.register(ark.filters.Filter.LOAD_NODE_DIR)
def keep_dir(value, path):
    """Do not process directories excluded by parent."""
    if path.name in EXCLUSIONS:
        return False
    path = str(path).replace(ark.site.src(), "").lstrip("/")
    return not any(path.startswith(x) for x in ark.site.config["exclude"])


@ark.filters.register(ark.filters.Filter.LOAD_NODE_FILE)
def keep_file(value, path):
    """Only process .md Markdown files."""
    return path.suffix == ".md"
