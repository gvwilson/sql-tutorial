---
title: "Modifying Data"
tagline: "Inserting, changing, and deleting values."
---

## Creating In-memory Database {: .aside}

[%inc in_memory_db.sh %]

-   "Connect" to an [%g in_memory_db "in-memory database" %]
    -   Changes aren't saved to disk
    -   Very useful for testing (discussed later)

## Creating Tables

[%inc create_work_job.sql %]

-   <code>create table <em>name</em></code> followed by parenthesized list of columns
-   Each column is a name, a data type, and optional extra information
    -   E.g., `not null` prevents nulls from being added
-   `.schema` is *not* standard SQL
-   SQLite has added a few things
    -   `create if not exists`
    -   upper-case keywords (SQL is case insensitive)

## Inserting Data

[%inc populate_work_job.sql %]
[%inc insert_values.out %]

## Following Along {: .aside}

-   [Download the examples]([% config "release" %])
-   Unzip that file
-   To re-create this database:
    -   `.read create_work_job.sql`
    -   `.read populate_work_job.sql`

## Exercise {: .exercise}

Using an in-memory database,
define a table called `notes` with two text columns `author` and `note`
and then add three or four rows.
Use a query to check that the notes have been stored
and that you can (for example) select by author name.

What happens if you try to insert too many or too few values into `notes`?
What happens if you insert a number instead of a string into the `note` field?

## Updating Rows

[%inc update_work_job.sql %]
[%inc update_rows.out %]

-   (Almost) always specify row(s) to update using `where`
    -   Otherwise update all rows in table, which is usually not wanted

## Deleting Rows

[%inc delete_rows.sql mark=keep %]
[%inc delete_rows.out %]

-   Again, (almost) always specify row(s) to delete using `where`

## Exercise {: .exercise}

What happens if you try to delete rows that don't exist
(e.g., all entries in `work` that refer to `juna`)?

## Backing Up

[%inc backing_up.sql mark=keep %]
[%inc backing_up.out %]

-   We will explore another strategy based on [%g tombstone "tombstones" %] below

## Exercise {: .exercise}

Saving and restoring data as text:

1.  Re-create the `notes` table in an in-memory database
    and then use SQLite's `.output` and `.dump` commands
    to save the database to a file called `notes.sql`.
    Inspect the contents of this file:
    how has your data been stored?

2.  Start a fresh SQLite session
    and load `notes.sql` using the `.read` command.
    Inspect the database using `.schema` and `select *`:
    is everything as you expected?

Saving and restoring data in binary format:

1.  Re-create the `notes` table in an in-memory database once again
    and use SQLite's `.backup` command to save it to a file called `notes.db`.
    Inspect this file using `od -c notes.db` or a text editor that can handle binary data:
    how has your data been stored?

2.  Start a fresh SQLite session
    and load `notes.db` using the `.restore` command.
    Inspect the database using `.schema` and `select *`:
    is everything as you expected?

## Check Understanding {: .aside}

[% figure
   slug="datamod_concept_map"
   img="datamod_concept_map.svg"
   caption="data definition and modification"
   alt="box and arrow diagram of concepts relatd to defining and modifying data"
%]
