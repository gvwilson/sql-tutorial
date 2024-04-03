---
title: "Python"
tagline: "Using databases from other languages."
---

## Querying from Python

[%inc basic_python_query.py %]
[%inc basic_python_query.out %]

-   `sqlite3` is part of Python's standard library
-   Create a connection to a database file
-   Get a [%g cursor "cursor" %] by executing a query
    -   More common to create cursor and use that to run queries
-   Fetch all rows at once as list of tuples

## Incremental Fetch

[%inc incremental_fetch.py %]
[%inc incremental_fetch.out %]

-   `cursor.fetchone` returns `None` when no more data
-   There is also `fetchmany(N)` to fetch (up to) a certain number of rows

## Insert, Delete, and All That

[%inc insert_delete.py %]
[%inc insert_delete.out %]

-   Each `execute` is its own transaction

## Interpolating Values

[%inc interpolate.py %]
[%inc interpolate.out %]

-   From [XKCD][xkcd-tables]

[% figure
   slug="python_xkcd"
   img="xkcd_327_exploits_of_a_mom.png"
   alt="XKCD cartoon showing a mother scolding a school for not being more careful about SQL injection attacks"
   caption="XKCD Exploits of a Mom"
%]

## Exercise {: .exercise}

Write a Python script that takes island, species, sex, and other values as command-line arguments
and inserts an entry into the penguins database.

## Script Execution

[%inc script_execution.py %]
[%inc script_execution.out %]

-   But what if something goes wrong?

## SQLite Exceptions in Python

[%inc exceptions.py %]
[%inc exceptions.out %]

## Python in SQLite

[%inc embedded_python.py %]
[%inc embedded_python.out %]

-   SQLite calls back into Python to execute the function
-   Other databases can run Python (and other languages) in the database server process
-   Be careful

## Handling Dates and Times

[%inc dates_times.py %]
[%inc dates_times.out %]

-   `sqlite3.PARSE_DECLTYPES` tells `sqlite3` library to use converts based on declared column types
-   Adapt on the way in, convert on the way out

## Exercise {: .exercise}

Write a Python adapter that truncates real values to two decimal places
as they are being written to the database.

## SQL in Jupyter Notebooks

[%inc install_jupysql.sh %]

-   And then inside the notebook:

[%inc load_ext.text %]

-   Loads extension

[%inc jupyter_connect.text %]
[%inc jupyter_connect.out %]

-   Connects to database
    -   `sqlite://` with two slashes is the protocol
    -   `/data/penguins.db` (one leading slash) is a local path
-   Single percent sign `%sql` introduces one-line command
-   Use double percent sign `%%sql` to indicate that the rest of the cell is SQL

[%inc jupyter_select.text %]
[%inc jupyter_select.out %]

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

## Pandas and SQL

[%inc install_pandas.sh %]
[%inc select_pandas.py %]
[%inc select_pandas.out %]

-   Be careful about datatype conversion when using [Pandas][pandas]

## Exercise {: .exercise}

Write a command-line Python script that uses Pandas to re-create the penguins database.

## Polars and SQL

[%inc install_polars.sh %]
[%inc select_polars.py %]
[%inc select_polars.out %]

-   The [%g uri "Uniform Resource Identifier" %] (URI) specifies the database
-   The query is the query
-   Use the ADBC engine instead of the default ConnectorX with [Polars][polars]

## Exercise {: .exercise}

Write a command-line Python script that uses Polars to re-create the penguins database.

## Object-Relational Mappers

[%inc orm.py %]
[%inc orm.out %]

-   An [%g orm "object-relational mapper" %] (ORM) translates table columns to object properties and vice versa
-   [SQLModel][sqlmodel] relies on Python type hints

## Exercise {: .exericse}

Write a command-line Python script that uses SQLModel to re-create the penguins database.

## Relations with ORMs

[%inc orm_relation.py mark=keep %]
[%inc orm_relation.out %]

-   Make foreign keys explicit in class definitions
-   SQLModel automatically does the join
    -   The two staff with no department aren't included in the result
