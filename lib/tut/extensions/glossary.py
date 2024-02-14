"""Handle glossary references and glossary."""

import ark
import shortcodes
import util


@shortcodes.register("g")
def glossary_ref(pargs, kwargs, node):
    """Handle [% g key "text" %] glossary reference shortcode."""
    util.require(
        (len(pargs) == 2) and (not kwargs),
        f"Bad 'g' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    key, text = pargs
    return f'<a href="#g:{key}">{util.markdownify(text)}</a>'


@shortcodes.register("glossary")
def glossary(pargs, kwargs, node):
    """Convert glossary to Markdown."""
    util.require(
        (not pargs) and (not kwargs),
        f"Bad 'glossary' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    lang = ark.site.config["lang"]
    glossary = util.glossary()
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
    return f'<dt id="g:{key}">{term}{acronym}</dt><dd>{defn}</dd>'
