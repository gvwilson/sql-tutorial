# Contributing

Contributions are very welcome.
Please file issues or submit pull requests in our GitHub repository.
All contributors will be acknowledged.

## In Brief

-   Use `pip install -r requirements.txt`
    to install the packages required by the helper tools and Python examples.
    You may wish to create a new virtual environment before doing so.
    All code has been tested with Python 3.12.1.

-   The tutorial lives in `src/*/index.md`,
    which is translated into a static GitHub Pages website using [Ark][ark].

-   The source files for examples are in their section directories
    along with captured output in `.out` files.

-   `Makefile` contains the commands used to re-run each example.
    If you add a new example,
    please add a corresponding rule in `Makefile`.
    -   `make depend.mk` rebuilds the list of extra dependencies.
        Please do not update `depend.mk` by hand.

-   Use a level-2 heading for each sub-topic.
    Use `{: .aside}` for an aside
    or `{: .exercise}` for exercise.

-   Use `[%inc "file.ext" %]` to include a text file.
    If `mark=label` is present,
    only code between comments `[label]` and `[/label]` is kept.

-   Use `[% figure slug="some_slug" img="filename.ext" caption="text" alt="text" %]`
    to include a figure.

-   Use `[% g key "text" %]` to link to glossary entries.
    The text is inserted and highlighted;
    the key must identify an entry in `info/glossary.yml`,
    which is in [Glosario][glosario] format.

-   Please create SVG diagrams using [draw.io][draw_io].
    Please use 14-point Helvetica for text,
    solid 1-point black lines,
    and unfilled objects.

-   All external links are written using `[box][notation]` inline
    and defined in `info/links.yml`.

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

[draw_io]: https://www.drawio.com/
[jekyll]: https://jekyllrb.com/
[ghp]: https://pages.github.com/
[glosario]: https://glosario.carpentries.org/
[graphviz]: https://graphviz.org/
[mermaid]: https://mermaid.js.org/
[palmer_penguins]: https://allisonhorst.github.io/palmerpenguins/
[pandas]: https://pandas.pydata.org/
[polars]: https://pola.rs/
[postgresql]: https://www.postgresql.org/
[tidyverse]: https://www.tidyverse.org/
[udell]: https://blog.jonudell.net/
