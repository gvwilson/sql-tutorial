# Contributing

Contributions are very welcome.
Please file issues or submit pull requests in our [GitHub repository][repo].
All contributors will be acknowledged.

## In Brief

-   The tutorial lives in `index.md`,
    which is translated into a static GitHub Pages website using [Jekyll][jekyll].
-   The source files for all examples are in `src/`,
    while the output they generate is in `out/`.
-   Please use `{% raw %}{% include without.md file="some_file.sql" %}{% endraw %}`
    in `index.md` to include `src/some_file.sql` and `out/some_file.out`.
-   Please use `{% raw %}{% include miscfile.md file="src/some_file.ext" %}{% endraw %}`
    in `index.md` to include an arbitrary text file *without* automatically including output.
    (Note that `miscfile` requires a directory name such as `src`
    but `without` does not.)
-   Please see `Makefile` for the commands used to re-run each example.
    If you add a new example,
    please add a corresponding rule in `Makefile`.
-   SVG images used in the tutorial are in `img/`
    and can be edited using [draw.io][draw-io].
-   Please use `pip install -r requirements.txt`
    to install the packages required by the helper tools and Python examples.
    You may wish to create a new virtual environment before doing so.
    All code has been tested with Python 3.12.1.

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

[draw-io]: https://www.drawio.com/
[jeykll]: https://jekyllrb.com/
[palmer-penguins]: https://allisonhorst.github.io/palmerpenguins/
[repo]: https://github.com/{{site.repository}}
