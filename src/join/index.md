---
title: "Joins"
tagline: "Combining data from multiple tables."
---

## Combining Information

[%inc cross_join.sql mark=keep %]
[%inc cross_join.out %]

-   A [%g join "join" %] combines information from two tables
-   [%g cross_join "cross join" %] constructs their cross product
    -   All combinations of rows from each
-   Result isn't particularly useful: `job` and `name` values don't match
    -   I.e., the combined data has records whose parts have nothing to do with each other

## Inner Join

[%inc inner_join.sql mark=keep %]
[%inc inner_join.out %]

-   Use <code><em>table</em>.<em>column</em></code> notation to specify columns
    -   A column can have the same name as a table
-   Use <code>on <em>condition</em></code> to specify [%g join_condition "join condition" %]
-   Since `complain` doesn't appear in `job.name`, none of those rows are kept

## Exercise {: .exercise}

Re-run the query shown above using `where job = name` instead of the full `table.name` notation.
Is the shortened form easier or harder to read
and more or less likely to cause errors?

## Aggregating Joined Data

[%inc aggregate_join.sql mark=keep %]
[%inc aggregate_join.out %]

-   Combines ideas we've seen before
-   But Tay is missing from the table
    -   No records in the `job` table with `tay` as name
    -   So no records to be grouped and summed

## Left Join

[%inc left_join.sql mark=keep %]
[%inc left_join.out %]

-   A [%g left_outer_join "left outer join" %] keeps all rows from the left table
-   Fills missing values from right table with null

## Aggregating Left Joins

[%inc aggregate_left_join.sql mark=keep %]
[%inc aggregate_left_join.out %]

-   That's better, but we'd like to see 0 rather than a blank

## Coalescing Values

[%inc coalesce.sql mark=keep %]
[%inc coalesce.out %]

-   <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

## Full Outer Join {: .aside}

-   [%g full_outer_join "Full outer join" %] is the union of
    left outer join and [%g right_outer_join "right outer join" %]
-   Almost the same as cross join, but consider:

[%inc full_outer_join.sql %]
[%inc full_outer_join.out %]

-   A cross join would produce empty result

## Exercise {: .exercise}

Find the least time each person spent on any job.
Your output should show that `mik` and `po` each spent 0.5 hours on some job.
Can you find a way to show the name of the job as well
using the SQL you have seen so far?

## Check Understanding {: .aside}

[% figure
   slug="join_concept_map"
   img="join_concept_map.svg"
   caption="join"
   alt="box and arrow diagram of concepts related to joining tables"
%]
