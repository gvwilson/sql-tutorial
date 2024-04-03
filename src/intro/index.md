---
title: "Introduction"
tagline: "Where we're going and why."
---

## What This Is

-   Notes and working examples that instructors can use to perform a lesson
    -   Do *not* expect novices with no prior SQL experience to be able to learn from them
-   Musical analogy
    -   This is the chord changes and melody
    -   We expect instructors to create an arrangement and/or improvise while delivering
    -   See [*Teaching Tech Together*][t3] for background

## Scope {: .aside}

-   [intended audience][persona]
    -   Rachel has a master's degree in cell biology
        and now works in a research hospital doing cell assays.
    -   She learned a bit of R in an undergrad biostatistics course
        and has been through [the Carpentries lesson on the Unix shell][carpentries-shell].
    -   Rachel is thinking about becoming a data scientist
        and would like to understand how data is stored and managed.
    -   Her work schedule is unpredictable and highly variable,
        so she needs to be able to learn a bit at a time.
-   prerequisites
    -   basic Unix command line: `cd`, `ls`, `*` wildcard
    -   basic tabular data analysis: filtering rows, aggregating within groups
-   learning outcomes
    1.  Explain the difference between a database and a database manager.
    1.  Write SQL to select, filter, sort, group, and aggregate data.
    1.  Define tables and insert, update, and delete records.
    1.  Describe different types of join and write queries that use them to combine data.
    1.  Use windowing functions to operate on adjacent rows.
    1.  Explain what transactions are and write queries that roll back when constraints are violated.
    1.  Explain what triggers are and write SQL to create them.
    1.  Manipulate JSON data using SQL.
    1.  Interact with a database using Python directly, from a Jupyter notebook, and via an ORM.

## Setup {: .aside}

-   Download [the latest release]([% config "release" %])
-   Unzip the file in a temporary directory to create:
    -   `./db/*.db`: the [SQLite][sqlite] databases used in the examples
    -   `./src/*.*`: SQL queries, Python scripts, and other source code
    -   `./out/*.*`: expected output for examples

## Background Concepts {: .aside}

-   A [%g database "database" %] is a collection of data that can be searched and retrieved
-   A [%g dbms "database management system" %] (DBMS) is a program that manages a particular kind of database
-   Each DBMS stores data in its own way
    -   SQLite stores each database in a single file
    -   [PostgreSQL][postgresql] spreads information across many files for higher performance
-   DBMS can be a library embedded in other programs (SQLite) or a server (PostgreSQL)
-   A [%g rdbms "relational database management system" %] (RDBMS) stores data in [%g table "tables" %]
    and uses [SQL][sql] for queries
    -   Unfortunately, every RDBMS has its own dialect of SQL
-   There are also [%g nosql "NoSQL databases" %] like [MongoDB][mongodb] that don't use tables

[% figure
   slug="intro_concept_map"
   img="intro_concept_map.svg"
   caption="overview of major concepts"
   alt="box and arrow concept map of major concepts related to databases"
%]

## Connecting to Database {: .aside}

[%inc connect_penguins.sh %]

-   Not actually a query: starts an interactive session with the database in `db/penguins.db`
-   Alternative: provide a single query on the command line <code>sqlite3 <em>database</em> "<em>query</em>"</code>
-   Or put query in file and run <code>sqlite3 <em>database</em> < <em>filename</em></code>
-   Note: the `penguins` database contains two tables
    -   `penguins` is all the [Palmer Penguins][palmer_penguins] data
    -   `little_penguins` is a subset used in our first few queries
        to keep output readable

> To disconnect from an interactive database session,
> type Control-D or `.quit` on a line of its own.
> You may need to type a semi-colon `;` to close any unfinished query
> before SQLite will recognize your attempt to escape.

## Acknowledgments {: .aside}

This tutorial would not have been possible without:

-   [Andi Albrecht][albrecht_andi]'s [`sqlparse`][sqlparse] module
-   [Dimitri Fontaine][fontaine_dimitri]'s [*The Art of PostgreSQL*][art-postgresql]
-   David Rozenshtein's *The Essence of SQL* (now sadly out of print)

I would also like to thank the following people
for spotting issues, making suggestions, or submitting changes:

[% thanks %]
