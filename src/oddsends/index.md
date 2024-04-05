---
title: "Odds and Ends"
tagline: "A few more useful features of SQL."
---

## Selecting First and Last Rows

[%inc union_all.sql %]
[%inc union_all.out %]

-   `union all` combines records
    -   Keeps duplicates: `union` on its own only keeps unique records
    -   Which is more work but sometimes more useful
-   Yes, it feels like the extra `select * from` should be unnecessary

## Exercise {: .exercise}

Write a query whose result includes two rows for each Adelie penguin
in the `penguins` database.
How can you check that your query is working correctly?

## Intersection

[%inc intersect.sql %]
[%inc intersect.out %]

-   Rows involved must have the same structure
-   Intersection usually used when pulling values from different sources
    -   In the query above, would be clearer to use `where`

## Exercise {: .exercise}

Use `intersect` to find all Adelie penguins that weigh more than 4000 grams.
How can you check that your query is working correctly?

Use `explain query plan` to compare the `intersect`-based query you just wrote
with one that uses `where`.
Which query looks like it will be more efficient?
Why do you believe this?

## Exclusion

[%inc except.sql %]
[%inc except.out %]

-   Again, tables must have same structure
    -   And this would be clearer with `where`
-   SQL operates on sets, not tables, except where it doesn't

## Exercise {: .exercise}

Use `exclude` to find all Gentoo penguins that *aren't* male.
How can you check that your query is working correctly?

## Random Numbers and Why Not

[%inc random_numbers.sql %]
[%inc random_numbers.out %]

-   There is no way to seed SQLite's random number generator
-   Which means there is no way to reproduce its pseudo-random sequences
-   Which means you should *never* use it
    -   How are you going to debug something you can't re-run?

## Exercise {: .exercise}

Write a query that:

-   uses a CTE to create 1000 random numbers between 0 and 10 inclusive;

-   uses a second CTE to calculate their mean; and

-   uses a third CTE and [SQLite's built-in math functions][sqlite_math]
    to calculate their standard deviation.

## Creating an Index

[%inc create_use_index.sql %]
[%inc create_use_index.out %]

-   An [%g index "index" %] is an auxiliary data structure that enables faster access to records
    -   Spend storage space to buy speed
-   Don't have to mention it explicitly in queries
    -   Database manager will use it automatically
-   Unlike primary keys, SQLite supports defining indexes after the fact

## Generating Sequences

[%inc generate_sequence.sql %]
[%inc generate_sequence.out %]

-   A (non-standard) [%g table_valued_func "table-valued function" %]

## Generating Sequences Based on Data

[%inc data_range_sequence.sql %]
[%inc data_range_sequence.out %]

-   Must have the parentheses around the `min` and `max` selections to keep SQLite happy

## Generating Sequences of Dates

[%inc date_sequence.sql %]
[%inc date_sequence.out %]

-   SQLite represents dates as YYYY-MM-DD strings
    or as Julian days or as Unix milliseconds or…
    -   Julian days is fractional number of days since November 24, 4714 BCE
-   `julianday` and `date` convert back and forth
-   `julianday` is specific to SQLite
    -   Other databases have their own date handling functions

## Counting Experiments Started per Day Without Gaps

[%inc experiments_per_day.sql %]
[%inc experiments_per_day.out %]

## Exercise {: .exercise}

What does the expression `date('now', 'start of month', '+1 month', '-1 day')` produce?
(You may find [the documentation on SQLite's date and time functions][sqlite_datetime] helpful.)

## Self Join

[%inc self_join.sql %]
[%inc self_join.out %]

-   Join a table to itself
    -   Use `as` to create [%g alias "aliases" %] for copies of tables to distinguish them
    -   Nothing special about the names `left` and `right`
-   Get all \\( n^2 \\) pairs, including person with themself

## Generating Unique Pairs

[%inc unique_pairs.sql %]
[%inc unique_pairs.out %]

-   `left.ident < right.ident` ensures distinct pairs without duplicates
    -   Query uses `left.ident <= 4 and right.ident <= 4` to shorten output
-   Quick check: \\( n(n-1)/2 \\) pairs

## Filtering Pairs

[%inc filter_pairs.sql %]
[%inc filter_pairs.out %]

## Existence and Correlated Subqueries

[%inc correlated_subquery.sql %]
[%inc correlated_subquery.out %]

-   Endocrinology is missing from the list
-   `select 1` could equally be `select true` or any other value
-   A [%g correlated_subquery "correlated subquery" %] depends on a value from the outer query
    -   Equivalent to nested loop

## Nonexistence

[%inc nonexistence.sql %]
[%inc nonexistence.out %]

## Exercise {: .exercise}

Can you rewrite the previous query using `exclude`?
If so, is your new query easier to understand?
If the query cannot be rewritten, why not?

## Avoiding Correlated Subqueries {: .aside}

[%inc avoid_correlated_subqueries.sql %]
[%inc avoid_correlated_subqueries.out %]

-   The join might or might not be faster than the correlated subquery
-   Hard to find unstaffed departments without either `not exists` or `count` and a check for 0

## Lead and Lag

[%inc lead_lag.sql %]
[%inc lead_lag.out %]

-   Use `strftime` to extract year and month
    -   Clumsy, but date/time handling is not SQLite's strong point
-   Use [%g window_func "window functions" %] `lead` and `lag` to shift values
    -   Unavailable values at the top or bottom are null

## Boundaries {: .aside}

-   [Documentation on SQLite's window functions][sqlite_window] describes
    three frame types and five kinds of frame boundary
-   It feels very ad hoc, but so does the real world

## Windowing Functions

[%inc window_functions.sql %]
[%inc window_functions.out %]

-   `sum() over` does a running total
-   `cume_dist()` is fraction *of rows seen so far*
-   So `num_done` column is number of experiments done…
-   …`completed_progress` is the fraction of experiments done…
-   …and `linear_progress` is the fraction of time passed

## Explaining Another Query Plan {: .aside}

[%inc explain_window_function.sql %]
[%inc explain_window_function.out %]

-   Becomes useful…eventually

## Partitioned Windows

[%inc partition_window.sql %]
[%inc partition_window.out %]

-   `partition by` creates groups
-   So this counts experiments started since the beginning of each year

## Exercise {: .exercise}

Create a query that:

1.  finds the unique weights of the penguins in the `penguins` database;

2.  sorts them;

3.  finds the difference between each successive distinct weight; and

4.  counts how many times each unique difference appears.
