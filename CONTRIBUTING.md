# Contributing

Contributions are very welcome.
Please file issues or submit pull requests in our GitHub repository.
All contributors will be acknowledged.

## In Brief

-   Use `pip install -r requirements.txt`
    to install the packages required by the helper tools and Python examples.
    You may wish to create a new virtual environment before doing so.
    All code has been tested with Python 3.12.1.

-   The tutorial lives in `pages/index.md`,
    which is translated into a static GitHub Pages website using [Ark][ark].

-   The source files for examples are in `src/` and the output they generate is in `out/`.

-   `Makefile` contains the commands used to re-run each example.
    If you add a new example,
    please add a corresponding rule in `Makefile`.
    -   `make depend.mk` rebuilds the list of extra dependencies.
        Please do not update `depend.mk` by hand.

-   Use `[% section_start class="CLASS" title="TITLE" %]`
    at the start of the first section.
    The class can be `topic` for a numbered topic,
    `aside` for an unnumbered aside,
    or `exercise` for practice exercises.
    Topics and asides must have titled;
    exercise section do not (the name is filled in automatically).

-   Use `[% section_end %]`
    at the end of the final section.

-   Use `[% section_break class="CLASS" title="TITLE" %]`
    to end the previous section and start a new one.

-   Use `[% double stem="file" suffix="sql out" %]`
    to include `src/file.sql` and `out/file.out`.
    Any two suffixes can be provided, such as `"py out"`,
    but the first file will always be looked for in the `src` directory
    and the second in `out`.

-   Use `[% single "dir/file.ext" %]`
    in `index.md` to include an arbitrary text file *without* automatically including output.
    (Note that `single` requires a directory name such as `src` or `out` but `double` does not.)

-   By default, file inclusion strips out everything between `-- [keep]` and `-- [/keep]`
    for SQL files and `# [keep]` and `# [/keep]` for Python files.
    The start and end tags can be customized by passing `keep="label"`
    to the `single` or `double` inclusion tags.

-   Use `[% exercise %]` to introduce a numbered exercise.
    Do not leave a blank link between the inclusion and the text of the exercise.

-   Use `[% figure file="path" title="text" alt="text" %]` to include a numbered figure.

-   Use `[% g key "text" %]` to link to glossary entries.
    The text is inserted and highlighted;
    the key must identify an entry in `info/glossary.yml`,
    which is in [Glosario][glosario] format.

-   SVG diagrams are in `res/img/` and can be edited using [draw.io][draw-io].
    Please use 12-point Helvetica for text,
    solid 1-point black lines,
    and unfilled objects.

-   All external links are written using `[box][notation]` inline
    and defined in `info/tutorial.yml`.
    The shortcode `[% link_table %]` at the end of `index.md` fills in these links.

## Logical Structure

-   Introduction
    -   A *learner persona* that characterizes the intended audience in concrete terms.
    -   *Prerequisites* (which should be interpreted with reference to the learner persona).
    -   *Learning objectives* that define the tutorial's scope.
    -   *Setup instructions* that instructors and learners must go through in order to code along

-   *Topics* are numbered.
    Each contains one code sample, its output, and notes for the instructor.
    Learners are *not* expected to be able to understand topics without instructor elaboration.

-   *Asides* are not numbered,
    and contain code-less explanatory material,
    additional setup instructions,
    *concept maps* summarizing recently-introduced ideas,
    etc.

-   *Exercises* are numbered.
    An exercise section may include any number of exercises.

-   Topics of both kinds may contain *glossary references*
    and/or *explanatory diagrams*.

-   Appendices
    -   A *glossary* that defines terms called out in the topics.
    -   *Acknowledgments* that point at inspirations and thank contributors.

## Physical Structure

-   `CODE_OF_CONDUCT.md`: source for Code of Conduct
    -   `pages/conduct.md`: auxiliary file to translate CoC into HTML
-   `CONTRIBUTING.md`: this guide
    -   `pages/contributing.md`: auxiliary file to translate this guide into HTML
-   `LICENSE.md`: licenses for code and prose
    -   `pages/license.md`: auxiliary file to translate licenses into HTML
-   `Makefile`: commands for rebuilding examples
    -   Run `make` with no arguments to see available targets
-   `README.md`: home page
-   `config.py`: Ark configuration file
-   `info/`: auxiliary data files used to build website
    -   `info/glossary.yml`: glossary terms
    -   `info/links.yml`: link definitions
    -   `info/thanks.yml`: names of people to include in acknowledgments
-   `bin/`: helper programs (e.g., for generating databases)
-   `db/`: databases used in examples
-   `docs/`: generated website
-   `lib/`: Ark theme directory
    -   `lib/tut/`: tutorial theme
        -   `lib/tut/extensions/`: custom shortcodes
        -   `lib/tut/resources/`: static files
        -   `lib/tut/templates/`: the main `node.ibis` template and included files
-   `misc/`: miscellaneous files
    -   `jupysql.ipynb`: Jupyter notebook used in examples
    -   `penguins.csv`: [Palmer penguins][palmer-penguins] data
    -   `sql_keywords.txt`: all SQLite keywords
-   `out/`: generated output files for examples
-   `requirements.txt`: `pip` requirements file to build Python environment
-   `res/`: static resources
    -   `res/img/`: SVG diagrams
-   `src/`: source files for examples

## Tags for Issues and Pull Requests

-   `contribute-addition`: a pull request that contains new material
-   `contribute-change`: a pull request that changes or fixes existing material
-   `discuss`: discussion of proposed change or fix
-   `governance`: meta-discussion of project direction, etc.
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

Why Ark?
:   The first version of this tutorial used [Jekyll][jekyll]
    because it is the default for [GitHub Pages][ghp]
    and because its frustrating limitations would discourage contributors
    from messing around with the template instead of writing content.
    However,
    those limitations proved more frustrating than anticipated:
    in particular,
    very few data scientists speak Ruby,
    so previewing changes locally required them to install and use
    yet another language framework.

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
[jekyll]: https://jekyllrb.com/
[ghp]: https://pages.github.com/
[glosario]: https://glosario.carpentries.org/
[graphviz]: https://graphviz.org/
[mermaid]: https://mermaid.js.org/
[palmer-penguins]: https://allisonhorst.github.io/palmerpenguins/
[pandas]: https://pandas.pydata.org/
[polars]: https://pola.rs/
[postgresql]: https://www.postgresql.org/
[tidyverse]: https://www.tidyverse.org/
[udell]: https://blog.jonudell.net/
