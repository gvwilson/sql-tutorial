"""Handle glossary references and glossary."""

import ark
import shortcodes

import util


# Prefix glossary keys to avoid collision with e.g. chapter heading keys.
GL_PREFIX = "gl:"


@shortcodes.register("g")
def glossary_ref(pargs, kwargs, node):
    """Handle [%g key "text" %] glossary reference shortcode."""
    util.require(
        (len(pargs) == 2) and (not kwargs),
        f"Bad 'g' in {node.path}: '{pargs}' and '{kwargs}'",
    )
    key, text = pargs
    cls = 'class="gl-ref"'
    href = f'href="@root/glossary/#{GL_PREFIX}{key}"'
    return f'<a {cls} {href} markdown="1">{text}</a>'


@shortcodes.register("glossary")
def glossary(pargs, kwargs, node):
    """Handle [% glossary %] shortcode."""
    util.require(
        (not pargs) and (not kwargs),
        f"Bad 'glossary' in {node.path}: '{pargs}' and '{kwargs}'",
    )
    lang = ark.site.config["lang"]
    glossary = util.load_glossary()

    try:
        glossary.sort(key=lambda x: x[lang]["term"].lower())
    except KeyError as exc:
        util.fail(f"Glossary entries missing key, term, or {lang}: {exc}.")

    entries = "\n\n".join([_as_markdown(entry, lang) for entry in glossary])
    return f'<dl class="glossary">\n{entries}\n</dl>'


def _as_markdown(entry, lang):
    """Convert a single glossary entry to Markdown."""
    key = entry["key"]
    term = util.markdownify(entry[lang]["term"])
    acronym = f" ({entry[lang]['acronym']})" if "acronym" in entry[lang] else ""
    defn = util.markdownify(entry[lang]["def"])
    return f'<dt id="{GL_PREFIX}{key}">{term}{acronym}</dt><dd>{defn}</dd>'
