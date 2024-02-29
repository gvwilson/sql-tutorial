"""Handle file inclusions."""

from pathlib import Path
import shortcodes
import util


COMMENT = {
    "py": "#",
    "sql": "--",
}


@shortcodes.register("multi")
def multi(pargs, kwargs, node):
    """Handle inclusion of multiple files."""
    util.require(
        (len(pargs) > 0) and (not kwargs),
        f"Bad 'multi' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    return "\n".join([single([filename], {}, node) for filename in pargs])


@shortcodes.register("single")
def single(pargs, kwargs, node):
    """Handle inclusion of a single file."""
    util.require(
        (len(pargs) == 1) and set(kwargs.keys()).issubset({"keep"}),
        f"Bad 'single' shortcode in {node.path} with '{pargs}' and '{kwargs}'",
    )
    filename = Path(pargs[0])
    suffix = filename.suffix.lstrip(".")
    keep = kwargs.get("keep", "keep")
    text = filename.read_text()

    if suffix in COMMENT:
        comment = COMMENT[suffix]
        before = f"{comment} [{keep}]"
        after = f"{comment} [/{keep}]"
        before_in = before in text
        after_in = after in text
        if before_in and after_in:
            text = text.split(before)[1].split(after)[0]
        elif before_in or after_in:
            util.fail(
                f"Mis-match start/end keep with '{keep}' in {filename} in {node.path}"
            )

    lang = "plaintext" if suffix == "out" else suffix

    lines = [
        f'<p class="inclusion"><a href="{filename}">{filename}</a></p>',
        f'<div class="language-{lang}" markdown="1">',
        f"```{suffix}",
        f"{text.strip()}",
        "```",
        "</div>",
    ]
    result = "\n".join(lines)
    return result
