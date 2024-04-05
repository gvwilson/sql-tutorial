---
title: "Selecting"
tagline: "Getting values from tables."
---

## Selecting Constant

[%inc select_1.sql %]
[%inc select_1.out %]

-   `select` is a keyword
-   Normally used to select data from table…
-   …but if all we want is a constant value, we don't need to specify one
-   Semi-colon terminator is required

## Selecting All Values from Table

[%inc select_star.sql %]
[%inc select_star.out %]

-   An actual [%g query "query" %]
-   Use `*` to mean "all columns"
-   Use <code>from <em>tablename</em></code> to specify table
-   Output format is not particularly readable

## Administrative Commands {: .aside}

[%inc admin_commands.sql %]
[%inc admin_commands.out %]

-   `.mode markdown` and `.headers on` make the output more readable
-   These SQLite [%g admin_command "administrative commands" %]
    start with `.` and *aren't* part of the SQL standard
    -   PostgreSQL's special commands start with `\`
-   Each command must appear on a line of its own
-   Use `.help` for a complete list
-   And as mentioned earlier, use `.quit` to quit

## Specifying Columns

[%inc specify_columns.sql %]
[%inc specify_columns.out %]

-   Specify column names separated by commas
    -   In any order
    -   Duplicates allowed
-   Line breaks encouraged for readability

## Sorting

[%inc sort.sql %]
[%inc sort.out %]

-   `order by` must follow `from` (which must follow `select`)
-   `asc` is ascending, `desc` is descending
    -   Default is ascending, but please specify

## Exercise {: .exercise}

Write a SQL query to select the sex and body mass columns from the `little_penguins` in that order,
sorted such that the largest body mass appears first.

## Limiting Output

-   Full dataset has 344 rows

[%inc limit.sql %]
[%inc limit.out %]

-   Comments start with `--` and run to the end of the line
-   <code>limit <em>N</em></code> specifies maximum number of rows returned by query

## Paging Output

[%inc page.sql %]
[%inc page.out %]

-   <code>offset <em>N</em></code> must follow `limit`
-   Specifies number of rows to skip from the start of the selection
-   So this query skips the first 3 and shows the next 10

## Removing Duplicates

[%inc distinct.sql %]
[%inc distinct.out %]

-   `distinct` keyword must appear right after `select`
    -   SQL was supposed to read like English
-   Shows distinct combinations
-   Blanks in `sex` column show missing data
    -   We'll talk about this in a bit

## Exercise {: .exercise}

1.  Write a SQL query to select the islands and species
    from rows 50 to 60 inclusive of the `penguins` table.
    Your result should have 11 rows.

2.  Modify your query to select distinct combinations of island and species
    from the same rows
    and compare the result to what you got in part 1.

## Filtering Results

[%inc filter.sql %]
[%inc filter.out %]

-   <code>where <em>condition</em></code> [%g filter "filters" %] the rows produced by selection
-   Condition is evaluated independently for each row
-   Only rows that pass the test appear in results
-   Use single quotes for `'text data'` and double quotes for `"weird column names"`
    -   SQLite will accept double-quoted text data but [SQLFluff][sqlfluff] will complain

## Exercise {: .exercise}

1.  Write a query to select the body masses from `penguins` that are less than 3000.0 grams.

2.  Write another query to select the species and sex of penguins that weight less than 3000.0 grams.
    This shows that the columns displayed and those used in filtering are independent of each other.

## Filtering with More Complex Conditions

[%inc filter_and.sql %]
[%inc filter_and.out %]

-   `and`: both sub-conditions must be true
-   `or`: either or both part must be true
-   Notice that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test
    -   We'll talk about this in a bit

## Exercise {: .exercise}

1.  Use the `not` operator to select penguins that are *not* Gentoos.

2.  SQL's `or` is an [%g inclusive_or "inclusive or" %]:
    it succeeds if either *or both* conditions are true.
    SQL does not provide a specific operator for [%g exclusive_or "exclusive or" %],
    which is true if either *but not both* conditions are true,
    but the same effect can be achieved using `and`, `or`, and `not`.
    Write a query to select penguins that are female *or* on Torgersen Island *but not both*.

## Doing Calculations

[%inc calculations.sql %]
[%inc calculations.out %]

-   Can do the usual kinds of arithmetic on individual values
    -   Calculation done for each row independently
-   Column name shows the calculation done

## Renaming Columns

[%inc rename_columns.sql %]
[%inc rename_columns.out %]

-   Use <code><em>expression</em> as <em>name</em></code> to rename
-   Give result of calculation a meaningful name
-   Can also rename columns without modifying

## Exercise {: .exercise}

Write a single query that calculates and returns:

1.  A column called `what_where` that has the species and island of each penguin
    separated by a single space.
2.  A column called `bill_ratio` that has the ratio of bill length to bill depth.

You can use the `||` operator to concatenate text to solve part 1,
or look at [the documentation for SQLite's `format()` function][sqlite_format].

## Check Understanding {: .aside}

[% figure
   slug="select_concept_map"
   img="select_concept_map.svg"
   alt="box and arrow diagram of concepts related to selection"
   caption="selection"
%]
