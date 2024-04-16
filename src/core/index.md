---
title: "Core Features"
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

[%inc specify_columns.penguins.sql %]
[%inc specify_columns.penguins.out %]

-   Specify column names separated by commas
    -   In any order
    -   Duplicates allowed
-   Line breaks encouraged for readability

## Sorting

[%inc sort.penguins.sql %]
[%inc sort.penguins.out %]

-   `order by` must follow `from` (which must follow `select`)
-   `asc` is ascending, `desc` is descending
    -   Default is ascending, but please specify

## Exercise {: .exercise}

Write a SQL query to select the sex and body mass columns from the `little_penguins` in that order,
sorted such that the largest body mass appears first.

## Limiting Output

-   Full dataset has 344 rows

[%inc limit.penguins.sql %]
[%inc limit.penguins.out %]

-   Comments start with `--` and run to the end of the line
-   <code>limit <em>N</em></code> specifies maximum number of rows returned by query

## Paging Output

[%inc page.penguins.sql %]
[%inc page.penguins.out %]

-   <code>offset <em>N</em></code> must follow `limit`
-   Specifies number of rows to skip from the start of the selection
-   So this query skips the first 3 and shows the next 10

## Removing Duplicates

[%inc distinct.penguins.sql %]
[%inc distinct.penguins.out %]

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

[%inc filter.penguins.sql %]
[%inc filter.penguins.out %]

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

[%inc filter_and.penguins.sql %]
[%inc filter_and.penguins.out %]

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

[%inc calculations.penguins.sql %]
[%inc calculations.penguins.out %]

-   Can do the usual kinds of arithmetic on individual values
    -   Calculation done for each row independently
-   Column name shows the calculation done

## Renaming Columns

[%inc rename_columns.penguins.sql %]
[%inc rename_columns.penguins.out %]

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

## Calculating with Missing Values

[%inc show_missing_values.penguins.sql %]
[%inc show_missing_values.penguins.out %]

-   SQL uses a special value [%g null "<code>null</code>" %] to representing missing data
    -   Not 0 or empty string, but "I don't know"
-   Flipper length and body weight not known for one of the first five penguins
-   "I don't know" divided by 10 or 1000 is "I don't know"

## Exercise {: .exercise}

Use SQLite's `.nullvalue` command
to change the printed representation of null to the string `null`
and then re-run the previous query.
When will displaying null as `null` be easier to understand?
When might it be misleading?

## Null Equality

-   Repeated from earlier

[%inc filter.penguins.sql %]
[%inc filter.penguins.out %]

-   If we ask for female penguins the row with the missing sex drops out

[%inc null_equality.penguins.sql %]
[%inc null_equality.penguins.out %]

## Null Inequality

-   But if we ask for penguins that *aren't* female it drops out as well

[%inc null_inequality.penguins.sql %]
[%inc null_inequality.penguins.out %]

## Ternary Logic

[%inc ternary_logic.penguins.sql %]
[%inc ternary_logic.penguins.out %]

-   If we don't know the left and right values, we don't know if they're equal or not
-   So the result is `null`
-   Get the same answer for `null != null`
-   [%g ternary_logic "Ternary logic" %]

<table>
  <tbody>
    <tr>
      <th colspan="4">equality</th>
    </tr>
    <tr>
      <th></th>
      <th>X</th>
      <th>Y</th>
      <th>null</th>
    </tr>
    <tr>
      <th>X</th>
      <td>true</td>
      <td>false</td>
      <td>null</td>
    </tr>
    <tr>
      <th>Y</th>
      <td>false</td>
      <td>true</td>
      <td>null</td>
    </tr>
    <tr>
      <th>null</th>
      <td>null</td>
      <td>null</td>
      <td>null</td>
    </tr>
  </tbody>
</table>

## Handling Null Safely

[%inc safe_null_equality.penguins.sql %]
[%inc safe_null_equality.penguins.out %]

-   Use `is null` and `is not null` to handle null safely
-   Other parts of SQL handle nulls specially

## Exercise {: .exercise}

1.  Write a query to find penguins whose body mass is known but whose sex is not.

2.  Write another query to find penguins whose sex is known but whose body mass is not.

## Check Understanding {: .aside}

[% figure
   slug="missing_concept_map"
   img="missing_concept_map.svg"
   alt="box and arrow diagram of concepts related to null values in SQL"
   caption="missing values"
%]

## Aggregating

[%inc simple_sum.penguins.sql %]
[%inc simple_sum.penguins.out %]

-   [%g aggregation "Aggregation" %] combines many values to produce one
-   `sum` is an [%g aggregation_func "aggregation function" %]
-   Combines corresponding values from multiple rows

## Common Aggregation Functions

[%inc common_aggregations.penguins.sql %]
[%inc common_aggregations.penguins.out %]

-   This actually shouldn't work:
    can't calculate maximum or average if any values are null
-   SQL does the useful thing instead of the right one

## Exercise {: .exercise}

What is the average body mass of penguins that weight more than 3000.0 grams?

## Counting

[%inc count_behavior.penguins.sql %]
[%inc count_behavior.penguins.out %]

-   `count(*)` counts rows
-   <code>count(<em>column</em>)</code> counts non-null entries in column
-   <code>count(distinct <em>column</em>)</code> counts distinct non-null entries

## Exercise {: .exercise}

How many different body masses are in the penguins dataset?

## Grouping

[%inc simple_group.penguins.sql %]
[%inc simple_group.penguins.out %]

-   Put rows in [%g group "groups" %] based on distinct combinations of values in columns specified with `group by`
-   Then perform aggregation separately for each group
-   But which is which?

## Behavior of Unaggregated Columns

[%inc unaggregated_columns.penguins.sql %]
[%inc unaggregated_columns.penguins.out %]

-   All rows in each group have the same value for `sex`, so no need to aggregate

## Arbitrary Choice in Aggregation

[%inc arbitrary_in_aggregation.penguins.sql %]
[%inc arbitrary_in_aggregation.penguins.out %]

-   If we don't specify how to aggregate a column,
    SQLite chooses *any arbitrary value* from the group
    -   All penguins in each group have the same sex because we grouped by that, so we get the right answer
    -   The body mass values are in the data but unpredictable
    -   A common mistake
-   Other database managers don't do this
    -   E.g., PostgreSQL complains that column must be used in an aggregation function

## Exercise {: .exercise}

Explain why the output of the previous query
has a blank line before the rows for female and male penguins.

Write a query that shows each distinct body mass in the penguin dataset
and the number of penguins that weigh that much.

## Filtering Aggregated Values

[%inc filter_aggregation.penguins.sql %]
[%inc filter_aggregation.penguins.out %]

-   Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

## Readable Output

[%inc readable_aggregation.penguins.sql %]
[%inc readable_aggregation.penguins.out %]

-   Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

## Filtering Aggregate Inputs

[%inc filter_aggregate_inputs.penguins.sql %]
[%inc filter_aggregate_inputs.penguins.out %]

-   <code>filter (where <em>condition</em>)</code> applies to *inputs*

## Exercise {: .exercise}

Write a query that uses `filter` to calculate the average body masses
of heavy penguins (those over 4500 grams)
and light penguins (those under 3500 grams)
simultaneously.
Is it possible to do this using `where` instead of `filter`?

## Check Understanding {: .aside}

[% figure
   slug="aggregate_concept_map"
   img="aggregate_concept_map.svg"
   caption="aggregation"
   alt="box and arrow diagram of concepts related to aggregation in SQL"
%]

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
[%inc show_work_job.memory.out %]

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
[%inc show_after_update.memory.out %]

-   (Almost) always specify row(s) to update using `where`
    -   Otherwise update all rows in table, which is usually not wanted

## Deleting Rows

[%inc delete_rows.memory.sql mark=keep %]
[%inc delete_rows.memory.out %]

-   Again, (almost) always specify row(s) to delete using `where`

## Exercise {: .exercise}

What happens if you try to delete rows that don't exist
(e.g., all entries in `work` that refer to `juna`)?

## Backing Up

[%inc backing_up.memory.sql mark=keep %]
[%inc backing_up.memory.out %]

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

## Combining Information

[%inc cross_join.memory.sql mark=keep %]
[%inc cross_join.memory.out %]

-   A [%g join "join" %] combines information from two tables
-   [%g cross_join "cross join" %] constructs their cross product
    -   All combinations of rows from each
-   Result isn't particularly useful: `job` and `name` values don't match
    -   I.e., the combined data has records whose parts have nothing to do with each other

## Inner Join

[%inc inner_join.memory.sql mark=keep %]
[%inc inner_join.memory.out %]

-   Use <code><em>table</em>.<em>column</em></code> notation to specify columns
    -   A column can have the same name as a table
-   Use <code>on <em>condition</em></code> to specify [%g join_condition "join condition" %]
-   Since `complain` doesn't appear in `job.name`, none of those rows are kept

## Exercise {: .exercise}

Re-run the query shown above using `where job = name` instead of the full `table.name` notation.
Is the shortened form easier or harder to read
and more or less likely to cause errors?

## Aggregating Joined Data

[%inc aggregate_join.memory.sql mark=keep %]
[%inc aggregate_join.memory.out %]

-   Combines ideas we've seen before
-   But Tay is missing from the table
    -   No records in the `job` table with `tay` as name
    -   So no records to be grouped and summed

## Left Join

[%inc left_join.memory.sql mark=keep %]
[%inc left_join.memory.out %]

-   A [%g left_outer_join "left outer join" %] keeps all rows from the left table
-   Fills missing values from right table with null

## Aggregating Left Joins

[%inc aggregate_left_join.memory.sql mark=keep %]
[%inc aggregate_left_join.memory.out %]

-   That's better, but we'd like to see 0 rather than a blank

## Coalescing Values

[%inc coalesce.memory.sql mark=keep %]
[%inc coalesce.memory.out %]

-   <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

## Full Outer Join {: .aside}

-   [%g full_outer_join "Full outer join" %] is the union of
    left outer join and [%g right_outer_join "right outer join" %]
-   Almost the same as cross join, but consider:

[%inc full_outer_join.memory.sql %]
[%inc full_outer_join.memory.out %]

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
