---
title: "R"
tagline: "Using databases from R."
---

# Loading Libraries

[%inc load_connect.r %]
[%inc load_connect.out %]

-   Use `dplyr` to create queries
-   Database connections are coordinated by the DBI (DataBase Interface) package

## What Do We Have?

-  List tables with `dbListTables`

[%inc list_tables.r %]
[%inc list_tables.out %]

## Load Table as Dataframe

[%inc get_table.r %]
[%inc get_table.out %]

-   Retrieve a table with `tbl` function
    -   It need a connection and the name of the table

## How Did We Get Here?

[%inc show_query.r %]
[%inc show_query.out %]

-   `dplyr` functions generate `SELECT` statements
-   `show_query()` runs the SQL `EXPLAIN` command to show the SQL query

## Lazy Evaluation

[%inc filter_lazy.r %]
[%inc filter_lazy.out %]

-   `filter` generates a query using `WHERE <condition>` 
-   `dbplyr` call are lazy.
-   The SQL query is only evaluated when it is sent to the database
-   Running the `dplyr` call only returns a preview of the result

[%inc filter_collect.r %]
[%inc filter_collect.out %]

-   `collect` retrieves the complete result of the query
    -   Note that now the table has 152 rows

## Selecting Columns

[%inc select.r %]
[%inc select.out %]

-   R's `select` modifies the SQL `SELECT` statement
-   Selection helpers from `dplyr` (like `contains`) work

## Sorting

[%inc sort.r %]
[%inc sort.out %]

-   With `arrange` you `ORDER BY` the data
-   There is a `desc` function

## Exercise {: .exercise}

Find the lightest penguin on Dream Island by arranging the table accordingly.
Only show the species, island, and body mass.

### Solution

[%inc ex_lightest_penguin.r %]
[%inc ex_lightest_penguin.out %]

## Transforming Columns 

[%inc mutate.r %]
[%inc mutate.out %]

-   `mutate` also modifies the `SELECT` statement
    -   Naming the new variable works as the `AS` statement
    -   It is optional, but desirable.
-   If `select` it not present the query will return all the columns

## Aggregating 

[%inc aggregate.r %]
[%inc aggregate.out %]

-   `summarise` and `group_by` work together to generate a `GROUP BY` clause
-   `dplyr` defaults to SQL to handle missing values unless you use the `na.rm` argument in aggregation functions

## Exercise {: .exercise}

-   Calculate the ratio of bill length to bill depth for each penguin
-   Using the previous result, calculate the average ratio for each species

## Creating a Table

[%inc create_table.r %]

-   Write, overwrite, or append a data frame to a database table with `dbWriteTable` 
    -   `':memory:'` is a "path" that creates an in-memory database

## Exercise {: .exercise}

Create the table `job` with the values shown in [%t r_job_table %].

[% table slug=r_job_table tbl=job_table.tbl caption="Content of Job Table" %]

### Solution

[%inc ex_job_table.r %]

## Negation Done Wrong

-   Who doesn't calibrate?

[%inc negate_wrong.r %]
[%inc negate_wrong.out %]

-   Similar to pure SQL, the result is wrong (Mik does calibrate)
    -   But using subqueries with `dplyr` is not that simple

## Literal SQL

[%inc literal_sql.r %]

-   You can use literal SQL inside `sql`
    -   It returns an SQL object
-   Useful when R code is not enough to write a query

## Joining Tables

[%inc join.r %]
[%inc join.out %]

-   Joining tables with `dplyr` works as it does in SQL
    -   The `by` argument works as the `ON` statement
    -   In this case we join by `person`
-   Use `left_join`, `right_join`, `inner_join` or `full_join`
  
## Exercise {: .exercise}

Calculate how may hours each person worked by summing all jobs.

### Solution

[%inc ex_join.r %]
[%inc ex_join.out %]
