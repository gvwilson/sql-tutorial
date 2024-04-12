---
title: "Tools"
tagline: "Miscellaneous things that make life easier."
---

## Negating Incorrectly

-   Who doesn't calibrate?

[%inc negate_incorrectly.sql mark=keep %]
[%inc negate_incorrectly.out %]

-   But Mik *does* calibrate
-   Problem is that there's an entry for Mik cleaning
-   And since `'clean' != 'calibrate'`, that row is included in the results
-   We need a different approach…

## Set Membership

[%inc set_membership.sql mark=keep %]
[%inc set_membership.out %]

-   <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

## Subqueries

[%inc subquery_set.sql mark=keep %]
[%inc subquery_set.out %]

-   Use a [%g subquery "subquery" %] to select the people who *do* calibrate
-   Then select all the people who *aren't* in that set
-   Initially feels odd, but subqueries are useful in other ways

## Defining a Primary Key {: .aside}

-   Can use any field (or combination of fields) in a table as a [%g primary_key "primary key" %]
    as long as value(s) unique for each record
-   Uniquely identifies a particular record in a particular table

[%inc primary_key.sql %]
[%inc primary_key.out %]

## Exercise {: .exercise}

Does the `penguins` table have a primary key?
If so, what is it?
What about the `work` and `job` tables?

## Autoincrementing and Primary Keys

[%inc autoincrement.sql %]
[%inc autoincrement.out %]

-   Database [%g autoincrement "autoincrements" %] `ident` each time a new record is added
-   Common to use that field as the primary key
    -   Unique for each record
-   If Mik changes their name again,
    we only have to change one fact in the database
-   Downside: manual queries are harder to read (who is person 17?)

## Internal Tables {: .aside}

[%inc sequence_table.sql mark=keep %]
[%inc sequence_table.out %]

-   Sequence numbers are *not* reset when rows are deleted
    -   In part so that they can be used as primary keys

## Exercise {: .exercise}

Are you able to modify the values stored in `sqlite_sequence`?
In particular,
are you able to reset the values so that
the same sequence numbers are generated again?

## Altering Tables

[%inc alter_tables.sql mark=keep %]
[%inc alter_tables.out %]

-   Add a column after the fact
-   Since it can't be null, we have to provide a default value
    -   Really want to make it the primary key, but SQLite doesn't allow that after the fact
-   Then use `update` to modify existing records
    -   Can modify any number of records at once
    -   So be careful about `where` clause
-   An example of [%g data_migration "data migration" %]

## M-to-N Relationships {: .aside}

-   Relationships between entities are usually characterized as:
    -   [%g 1_to_1 "1-to-1" %]:
        fields in the same record
    -   [%g 1_to_many "1-to-many" %]:
        the many have a [%g foreign_key "foreign key" %] referring to the one's primary key
    -   [%g many_to_many "many-to-many" %]:
        don't know how many keys to add to records ("maximum" never is)
-   Nearly-universal solution is a [%g join_table "join table" %]
    -   Each record is a pair of foreign keys
    -   I.e., each record is the fact that records A and B are related

## Creating New Tables from Old

[%inc insert_select.sql mark=keep %]
[%inc insert_select.out %]

-   `new_work` is our join table
-   Each column refers to a record in some other table

## Removing Tables

[%inc drop_table.sql mark=keep %]
[%inc drop_table.out %]

-   Remove the old table and rename the new one to take its place
    -   Note `if exists`
-   Please back up your data first

## Exercise {: .exercise}

1.  Reorganize the penguins database:
    1.  Make a copy of the `penguins.db` file
        so that your changes won't affect the original.
    2.  Write a SQL script that reorganizes the data into three tables:
        one for each island.
    3.  Why is organizing data like this a bad idea?

2.  Tools like [Sqitch][sqitch] can manage changes to database schemas and data
    so that they can be saved in version control
    and rolled back if they are unsuccessful.
    Translate the changes made by the scripts above into Sqitch.
    Note: this exercise may take an hour or more.

## Comparing Individual Values to Aggregates

-   Go back to the original penguins database

[%inc compare_individual_aggregate.sql %]
[%inc compare_individual_aggregate.out %]

-   Get average body mass in subquery
-   Compare each row against that
-   Requires two scans of the data, but no way to avoid that
    -   Except calculating a running total each time a penguin is added to the table
-   Null values aren't included in the average or in the final results

## Exercise {: .exercise}

Use a subquery to find the number of penguins
that weigh the same as the lightest penguin.

## Comparing Individual Values to Aggregates Within Groups

[%inc compare_within_groups.sql %]
[%inc compare_within_groups.out %]

-   Subquery runs first to create temporary table `averaged` with average mass per species
-   Join that with `penguins`
-   Filter to find penguins heavier than average within their species

## Exercise {: .exercise}

Use a subquery to find the number of penguins
that weigh the same as the lightest penguin of the same sex and species.

## Common Table Expressions

[%inc common_table_expressions.sql %]
[%inc common_table_expressions.out %]

-   Use [%g cte "common table expression" %] (CTE) to make queries clearer
    -   Nested subqueries quickly become difficult to understand
-   Database decides how to optimize

## Explaining Query Plans {: .aside}

[%inc explain_query_plan.sql %]
[%inc explain_query_plan.out %]

-   SQLite plans to scan every row of the table
-   It will build a temporary [%g b_tree "B-tree data structure" %] to group rows

## Exercise {: .exercise}

Use a CTE to find
the number of penguins
that weigh the same as the lightest penguin of the same sex and species.

## Enumerating Rows

-   Every table has a special column called `rowid`

[%inc rowid.sql %]
[%inc rowid.out %]

-   `rowid` is persistent within a session
    -   I.e., if we delete the first 5 rows we now have row IDs 6…N
-   *Do not rely on row ID*
    -   In particular, do not use it as a key

## Exercise {: .exercise}

To explore how row IDs behave:

1.  Suppose that you create a new table,
    add three rows,
    delete those rows,
    and add the same values again.
    Do you expect the row IDs of the final rows to be 1–3 or 4–6?

2.  Using an in-memory database,
    perform the steps in part 1.
    Was the result what you expected?

## Conditionals

[%inc if_else.sql %]
[%inc if_else.out %]

-   <code>iif(<em>condition</em>, <em>true_result</em>, <em>false_result</em>)</code>
    -   Note: `iif` with two i's
-   May feel odd to think of `if`/`else` as a function,
    but common in [%g vectorization "vectorized" %] calculations

## Exercise {: .exercise}

How does the result of the previous query change
if the check for null body mass is removed?
Why is the result without that check misleading?

What does each of the expressions shown below produce?
Which ones do you think actually attempt to divide by zero?

1.  `iif(0, 123, 1/0)`
1.  `iif(1, 123, 1/0)`
1.  `iif(0, 1/0, 123)`
1.  `iif(1, 1/0, 123)`

## Selecting a Case

-   What if we want small, medium, and large?
-   Can nest `iif`, but quickly becomes unreadable

[%inc case_when.sql %]
[%inc case_when.out %]

-   Evaluate `when` options in order and take first
-   Result of `case` is null if no condition is true
-   Use `else` as fallback

## Exercise {: .exercise}

Modify the query above so that
the outputs are `"penguin is small"` and `"penguin is large"`
by concatenating the string `"penguin is "` to the entire `case`
rather than to the individual `when` branches.
(This exercise shows that `case`/`when` is an [%g expression "expression" %]
rather than a [%g statement "statement" %].)

## Checking a Range

[%inc check_range.sql %]
[%inc check_range.out %]

-   `between` can make queries easier to read
-   But be careful of the `and` in the middle

## Exercise {: .exercise}

The expression `val between 'A' and 'Z'` is true if `val` is `'M'` (upper case)
but false if `val` is `'m'` (lower case).
Rewrite the expression using [SQLite's built-in scalar functions][sqlite_function]
so that it is true in both cases.

| name      | purpose |
| --------- | ------- |
| `substr`  | Get substring given starting point and length |
| `trim`    | Remove characters from beginning and end of string |
| `ltrim`   | Remove characters from beginning of string |
| `rtrim`   | Remove characters from end of string |
| `length`  | Length of string |
| `replace` | Replace occurrences of substring with another string |
| `upper`   | Return upper-case version of string |
| `lower`   | Return lower-case version of string |
| `instr`   | Find location of first occurrence of substring (returns 0 if not found) |

## Yet Another Database {: .aside}

-   [%g er_diagram "Entity-relationship diagram" %] (ER diagram) shows relationships between tables
-   Like everything to do with databases, there are lots of variations

[% figure
   slug="assays_tables"
   img="assays_tables.svg"
   caption="assay database table diagram"
   alt="table-level diagram of assay database showing primary and foreign key relationships"
%]

[% figure
   slug="assays_er"
   img="assays_er.svg"
   caption="assay ER diagram"
   alt="entity-relationship diagram showing logical structure of assay database"
%]

[%inc assay_staff.sql %]
[%inc assay_staff.out %]

## Exercise {: .exercise}

Draw a table diagram and an ER diagram to represent the following database:

-   `person` has `id` and `full_name`
-   `course` has `id` and `name`
-   `section` has `course_id`, `start_date`, and `end_date`
-   `instructor` has `person_id` and `section_id`
-   `student` has `person_id`, `section_id`, and `status`

## Pattern Matching

[%inc like_glob.sql %]
[%inc like_glob.out %]

-   `like` is the original SQL pattern matcher
    -   `%` matches zero or more characters at the start or end of a string
    -   Case insensitive by default
-   `glob` supports Unix-style wildcards

## Exercise {: .exercise}

Rewrite the pattern-matching query shown above using `glob`.

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
