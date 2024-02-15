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
copy = [
    "*.db",
    "*.out",
    "*.py",
    "*.sh",
    "*.sql",
    "*.text",
]

# Enable various Markdown extensions.
markdown_settings = {
    "extensions": [
        "markdown.extensions.extra",
        "markdown.extensions.smarty",
        "pymdownx.superfences",
    ]
}
