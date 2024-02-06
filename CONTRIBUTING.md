# Contributing

Contributions are very welcome.
Please file issues or submit pull requests in our GitHub repository.
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

-   Use `{% raw %}{% include h2_numbered.md title="words" %}{% endraw %}`
    to create a numbered section
    that includes a runnable code example.

-   Use `{% raw %}{% include h2_unnumbered.md title="words" %}{% endraw %}`
    to create an unnumbered section
    that *doesn't* include a runnable code example.

-   Use `{% raw %}{% include double.md stem="file" suffix="sql out" %}{% endraw %}`
    in `index.md` to include `src/file.sql` and `out/file.out`.
    (Any two suffixes can be provided, such as `"py out"`.)

-   Use `{% raw %}{% include single.md file="dir/file.ext" %}{% endraw %}`
    in `index.md` to include an arbitrary text file *without* automatically including output.
    (Note that `single` requires a directory name such as `src` or `out` but `double` does not.)

-   Add important terms to `_info/glossary.yml`,
    which is in [Glosario][glosario] format.

-   Use `{% raw %}<a href="#g:key">text</span>{% endraw %}` to link to glossary entries.
    The key must identify an entry in `_data/glossary.yml`;
    the `#` makes it an in-page reference,
    while the `g:` prefix triggers CSS styling.

-   SVG images used in the tutorial are in `img/`
    and can be edited using [draw.io][draw-io].
    Please use 12-point Helvetica for text,
    solid 1-point black lines,
    and unfilled objects.

-   All external links are written using `{% raw %}[box][notation]{% endraw %}` inline
    and defined at the foot of the document.

## Logical Structure

-   Introduction
    -   A *learner persona* that characterizes the intended audience in concrete terms.
    -   *Prerequisites* (which should be interpreted with reference to the learner persona).
    -   *Learning objectives* that define the tutorial's scope.
    -   *Setup instructions* that instructors and learners must go through in order to code along
-   Episodes
    -   *Runnable episodes* are numbered.
        Each contains one code sample, its output, and notes for the instructor.
        Learners are *not* expected to be able to understand episodes without instructor elaboration.
    -   *Asides* are not numbered,
        and contain code-less explanatory material,
        additional setup instructions,
        *concept maps* summarizing recently-introduced ideas,
        etc.
    -   Episodes of both kinds may contain *glossary references*
        and/or *explanatory diagrams*.
-   Appendices
    -   A *glossary* that defines terms called out in the episodes.
    -   *Acknowledgments* that point at inspirations and thank contributors.

## Physical Structure

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
-   `res/`: CSS and JavaScript for styling site
-   `src/`: source files for examples

## Tags for Issues and Pull Requests

-   `contribute-addition`: a pull request that contains new material
-   `contribute-change`: a pull request that changes or fixes existing material
-   `governance`: discussion of direction, use, etc.
-   `help-wanted`: requires knowledge or skills the core maintainer lacks
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

Why make this tutorial freely available?
:   Because if we all give a little, we all get a lot.

[draw-io]: https://www.drawio.com/
[glosario]: https://glosario.carpentries.org/
[graphviz]: https://graphviz.org/
[jekyll]: https://jekyllrb.com/
[mermaid]: https://mermaid.js.org/
[palmer-penguins]: https://allisonhorst.github.io/palmerpenguins/
[pandas]: https://pandas.pydata.org/
[polars]: https://pola.rs/
[postgresql]: https://www.postgresql.org/
[tidyverse]: https://www.tidyverse.org/
[udell]: https://blog.jonudell.net/
