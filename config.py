# Tutorial data.
title = "The Querynomicon"
subtitle = "An Introduction to SQL for Wary Data Scientists"
repo = "https://github.com/gvwilson/sql-tutorial"
release = "https://github.com/gvwilson/sql-tutorial/raw/main/sql-tutorial.zip"
plausible = "gvwilson.github.io/sql-tutorial"
author = {
    "name": "Greg Wilson",
    "email": "gvwilson@third-bit.com",
}

# Theme information.
theme = "tut"
src_dir = "pages"
out_dir = "docs"
rouge_style = "github.css"
lang = "en"
extension = "/"

# Directories to copy verbatim.
copydir = [
    "db",
    "out",
    "src",
]

# Files to copy verbatim.
copyext = [
    ".db",
    ".out",
    ".py",
    ".sh",
    ".sql",
    ".text",
]

# Enable various Markdown extensions.
markdown_settings = {
    "extensions": [
        "markdown.extensions.extra",
        "markdown.extensions.smarty",
        "pymdownx.superfences",
    ]
}


if __name__ == "__main__":
    import sys
    USAGE = "usage: config.py [copydir | copyext]"
    status = 0
    if len(sys.argv) == 1:
        print(USAGE, file=sys.stderr)
    elif len(sys.argv) != 2:
        print(USAGE, file=sys.stderr)
        status = 1
    elif sys.argv[1] == "copydir":
        print(" ".join(copydir))
    elif sys.argv[1] == "copyext":
        print(" ".join(copyext))
    else:
        print(USAGE, file=sys.stderr)
        status = 1
    sys.exit(status)
