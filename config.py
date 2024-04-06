# Tutorial data.
title = "The Querynomicon"
subtitle = "An Introduction to SQL for Weary Data Scientists"
repo = "https://github.com/gvwilson/sql-tutorial"
plausible = "gvwilson.github.io/sql-tutorial"
site = f"https://{plausible}/"
release = "https://github.com/gvwilson/sql-tutorial/raw/main/sql-tutorial.zip"
author = {
    "name": "Greg Wilson",
    "email": "gvwilson@third-bit.com",
    "site": "https://third-bit.com/",
}
lang = "en"
highlight = "tango.css"

chapters = [
    "intro",
    "select",
    "missing",
    "aggregate",
    "datamod",
    "join",
    "toolbox",
    "moretools",
    "oddsends",
    "composite",
    "action",
    "recursive",
    "python",
    "psql",
    "finale",
]

appendices = [
    "license",
    "conduct",
    "contrib",
    "bib",
    "glossary",
    "author",
    "colophon",
]

unused = [
    "contents",
]

# Files to copy
copy = [
    "*.out",
    "*.png",
    "*.py",
    "*.sh",
    "*.sql",
    "*.svg",
]

# Files and directories to skip
exclude = {}

# Theme information.
theme = "mccole"
src_dir = "src"
out_dir = "docs"
extension = "/"

# Enable various Markdown extensions.
markdown_settings = {
    "extensions": [
        "markdown.extensions.extra",
        "markdown.extensions.smarty",
        "pymdownx.superfences",
    ]
}


# Display values for LaTeX generation.
if __name__ == "__main__":
    import sys

    USAGE = "usage: config.py [copydir | copyext | lang]"
    status = 0
    if len(sys.argv) == 1:
        print(USAGE, file=sys.stderr)
    elif len(sys.argv) != 2:
        print(USAGE, file=sys.stderr)
        status = 1
    elif sys.argv[1] == "lang":
        print(lang)
    else:
        print(USAGE, file=sys.stderr)
        status = 1
    sys.exit(status)
