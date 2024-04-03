---
title: "More Tools"
tagline: "Common table expressions, conditionals, and more."
---

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
   slug="moretools_assays_tables"
   img="moretools_assays_tables.svg"
   caption="assay database table diagram"
   alt="table-level diagram of assay database showing primary and foreign key relationships"
%]

[% figure
   slug="moretools_assays_er"
   img="moretools_assays_er.svg"
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
