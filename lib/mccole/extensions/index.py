"""Handle index shortcode and create index."""

import ark
import shortcodes

import util


@shortcodes.register("i", "/i")
def index_ref(pargs, kwargs, node, content):
    """Format index shortcode."""
    return content


@shortcodes.register("index")
def make_index(pargs, kwargs, node):
    """Handle [% index %] using saved data."""

    util.require(
        "_index_" in ark.site.config,
        "No index information has been added to site configuration",
    )

    # Calculate reference order for index links.
    all_slugs = ark.site.config["chapters"] + ark.site.config["appendices"]
    ordering = {slug: i for i, slug in enumerate(all_slugs)}

    # Invert index.
    lookup = {}
    for (slug, terms) in ark.site.config["_index_"].items():
        for t in terms:
            if t not in lookup:
                lookup[t] = set()
            lookup[t].add(slug)

    # Format index list.
    links = [
        _make_links(key, slugs, ordering)
        for key, slugs in sorted(lookup.items(), key=lambda x: x[0].lower())
    ]
    return "\n".join([
        '<ul class="ix-list">',
        *links,
        "</ul>",
    ])


def _make_links(key, slugs, ordering):
    """Turn a set of node slugs into links."""
    metadata = ark.site.config["_meta_"]
    paths = [f"@root/{s}/" for s in slugs]
    titles = [metadata[s]["title"] for s in slugs]
    triples = list(zip(slugs, paths, titles))
    triples.sort(key=lambda t: ordering[t[0]])
    result = ", ".join(
        f'<a class="ix-ref" ix-ref="{key}" href="{path}">{title}</a>'
        for (slug, path, title) in triples
    )
    if "!" in key:
        key = f"…{key.split('!')[-1]}"
    return f"<li>{key}: {result}</li>"
