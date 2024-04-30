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
    "core",
    "tools",
    "advanced",
    "python",
    "r",
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
    "*.r",
    "*.sh",
    "*.sql",
    "*.svg",
]

# Files and directories to skip
exclude = {
    "composite/img",
}

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

# Show theme.
if __name__ == "__main__":
    print(theme)
