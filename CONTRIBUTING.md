# Contributing

Contributions are very welcome.
Please file issues or submit pull requests in our [GitHub repository][repo].
All contributors will be acknowledged.

## In Brief

-   The tutorial lives in `index.md`,
    which is translated into a static GitHub Pages website using [Jekyll][jekyll].

-   The source files for examples are in `src/`,
    while the output they generate is in `out/`.

-   Use `pip install -r requirements.txt`
    to install the packages required by the helper tools and Python examples.
    You may wish to create a new virtual environment before doing so.
    All code has been tested with Python 3.12.1.

-   `Makefile` contains the commands used to re-run each example.
    If you add a new example,
    please add a corresponding rule in `Makefile`.

-   Use `{% raw %}{% include without.md file="file.sql" %}{% endraw %}`
    in `index.md` to include `src/file.sql` and `out/file.out`.

-   Use `{% raw %}{% include miscfile.md file="src/file.ext" %}{% endraw %}`
    in `index.md` to include an arbitrary text file *without* automatically including output.
    (Note that `miscfile` requires a directory name such as `src`
    but `without` does not.)

-   Wrap words or phrases in asterisks (e.g., `*word*`) for emphasis;
    wrap them in triple underscores (e.g., `___term___`) if they are glossary terms.

-   Add important terms to `_info/glossary.yml`,
    which is in [Glosario][glosario] format.

-   SVG images used in the tutorial are in `img/`
    and can be edited using [draw.io][draw-io].
    Please use 12-point Helvetica for text.

## Repository Contents

-   `CODE_OF_CONDUCT.md`: source for Code of Conduct
    -   `conduct_.md`: auxiliary file to translate CoC into HTML
-   `CONTRIBUTING.md`: this guide
    -   `contributing_.md`: auxiliary file to translate this guide into HTML
-   `LICENSE.md`: licenses for code and prose
    -   `license_.md`: auxiliary file to translate licenses into HTML
-   `Makefile`: commands for rebuilding examples
    -   Run `make` with no arguments to see available targets
-   `README.md`: home page
-   `_config.yml`: Jekyll configuration file
-   `_data/`: auxiliary data files used to build website
    -   `_data/thanks.yml`: names of people to include in acknowledgments
-   `_includes/`: Jekyll inclusions (discussed above)
-   `_layouts/`: Jekyll layouts
-   `_site/`: Jekyll output (not stored in version control)
-   `bin/`: helper programs (e.g., for generating databases)
-   `css/`: CSS files for styling site
-   `db/`: databases used in examples
-   `favicon.ico`: favicon used in generated site
-   `img/`: images used in tutorial
-   `index.md`: home page for generated website
-   `misc/`: miscellaneous files
    -   `jupysql.ipynb`: Jupyter notebook used in examples
    -   `penguins.csv`: [Palmer penguins][palmer-penguins] data
    -   `sql_keywords.txt`: all SQLite keywords
-   `out/`: generated output files for examples
-   `requirements.txt`: `pip` requirements file to build Python environment
-   `src/`: source files for examples

## Tags for Issues and Pull Requests

-   `contribute-addition`: a pull request that contains new material
-   `contribute-change`: a pull request that changes or fixes existing material
-   `governance`: discussion of direction, use, etc.
-   `in-content`: issue or PR is related to lesson content
-   `in-infrastructure`: issue or PR is related to build tools, styling, etc.
-   `report-bug`: issue reporting an error
-   `request-addition`: issue asking for new content
-   `request-change`: issue asking for a change to existing content

## FAQ

Why SQL?
:   Because if you dig down far enough,
    almost every data science project sits on top of a relational database.
    ([Jon Udell][udell] once called [PostgreSQL][postgresql]
    "an operating system for data science".)
    SQL's relational model has also been a powerful influence
    on dataframe libraries like [the tidyverse][tidyverse],
    [Pandas][pandas],
    and [Polars][polars];
    understanding the former therefore helps people understand the latter.

Why Jekyll?
:   It's the default for GitHub Pages,
    and if we used something more comfortable
    people would spend time fiddling with the tools instead of writing content.

Why Make?
:   It runs everywhere,
    no other build tool is a clear successor,
    and,
    like Jekyll,
    it's uncomfortable enough to use that people won't be tempted to fiddle with it
    when they could be writing.

Why hand-drawn figures rather than [Graphviz][graphviz] or [Mermaid][mermaid]?
:   Because it's faster to Just Effing Draw than it is
    to try to tweak layout parameters for text-to-diagram systems.
    If you really want to make developers' lives better,
    build a diff-and-merge tool for SVG:
    programmers shouldn't have to use punchard-compatible data formats in the 21st Century
    just to get the benefits of version control.

Why make this freely available?
:   If you have to ask, you wouldn't understand.

[draw-io]: https://www.drawio.com/
[glosario]: https://glosario.carpentries.org/
[graphviz]: https://graphviz.org/
[jeykll]: https://jekyllrb.com/
[mermaid]: https://mermaid.js.org/
[palmer-penguins]: https://allisonhorst.github.io/palmerpenguins/
[pandas]: https://pandas.pydata.org/
[polars]: https://pola.rs/
[postgresql]: https://www.postgresql.org/
[repo]: https://github.com/{{site.repository}}
[tidyverse]: https://www.tidyverse.org/
[udell]: https://blog.jonudell.net/
