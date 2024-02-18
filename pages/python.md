---
title: Python
---

<!-- ---------------------------------------------------------------- -->
[% section_start class="topic" title="Querying from Python" %]

[% double stem="basic_python_query" suffix="py out" %]

-   `sqlite3` is part of Python's standard library
-   Create a connection to a database file
-   Get a [%g cursor "cursor" %] by executing a query
    -   More common to create cursor and use that to run queries
-   Fetch all rows at once as list of tuples

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Incremental Fetch" %]

[% double stem="incremental_fetch" suffix="py out" %]

-   `cursor.fetchone` returns `None` when no more data
-   There is also `fetchmany(N)` to fetch (up to) a certain number of rows

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Insert, Delete, and All That" %]

[% double stem="insert_delete" suffix="py out" %]

-   Each `execute` is its own transaction

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Interpolating Values" %]

[% double stem="interpolate" suffix="py out" %]

-   From [XKCD][xkcd-tables]

[% figure
   file="img/xkcd_327_exploits_of_a_mom.png"
   title="XKCD Exploits of a Mom"
   alt="XKCD cartoon showing a mother scolding a school for not being more careful about SQL injection attacks"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a Python script that takes island, species, sex, and other values as command-line arguments
and inserts an entry into the penguins database.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Script Execution" %]

[% double stem="script_execution" suffix="py out" %]

-   But what if something goes wrong?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="SQLite Exceptions in Python" %]

[% double stem="exceptions" suffix="py out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Python in SQLite" %]

[% double stem="embedded_python" suffix="py out" %]

-   SQLite calls back into Python to execute the function
-   Other databases can run Python (and other languages) in the database server process
-   Be careful

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Handling Dates and Times" %]

[% double stem="dates_times" suffix="py out" %]

-   `sqlite3.PARSE_DECLTYPES` tells `sqlite3` library to use converts based on declared column types
-   Adapt on the way in, convert on the way out

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a Python adapter that truncates real values to two decimal places
as they are being written to the database.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="SQL in Jupyter Notebooks" %]

[% single "src/install_jupysql.sh" %]

-   And then inside the notebook:

[% single "src/load_ext.text" %]

-   Loads extension

[% double stem="jupyter_connect" suffix="text out" %]

-   Connects to database
    -   `sqlite://` with two slashes is the protocol
    -   `/data/penguins.db` (one leading slash) is a local path
-   Single percent sign `%sql` introduces one-line command
-   Use double percent sign `%%sql` to indicate that the rest of the cell is SQL

[% double stem="jupyter_select" suffix="text out" %]

<table>
  <thead>
    <tr>
      <th>species</th>
      <th>num</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Adelie</td>
      <td>152</td>
    </tr>
    <tr>
      <td>Chinstrap</td>
      <td>68</td>
    </tr>
    <tr>
      <td>Gentoo</td>
      <td>124</td>
    </tr>
  </tbody>
</table>

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Pandas and SQL" %]

[% single "src/install_pandas.sh" %]
[% double stem="select_pandas" suffix="py out" %]

-   Be careful about datatype conversion when using [Pandas][pandas]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a command-line Python script that uses Pandas to re-create the penguins database.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Polars and SQL" %]

[% single "src/install_polars.sh" %]
[% double stem="select_polars" suffix="py out" %]

-   The [%g uri "Uniform Resource Identifier" %] (URI) specifies the database
-   The query is the query
-   Use the ADBC engine instead of the default ConnectorX with [Polars][polars]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a command-line Python script that uses Polars to re-create the penguins database.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Object-Relational Mappers" %]

[% double stem="orm" suffix="py out" %]

-   An [%g orm "object-relational mapper" %] (ORM) translates table columns to object properties and vice versa
-   [SQLModel][sqlmodel] relies on Python type hints

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a command-line Python script that uses SQLModel to re-create the penguins database.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Relations with ORMs" %]

[% double stem="orm_relation" suffix="py out" %]

-   Make foreign keys explicit in class definitions
-   SQLModel automatically does the join
    -   The two staff with no department aren't included in the result

[% section_end %]
