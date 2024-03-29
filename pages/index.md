<div class="row">
  <div class="col-4 center">
    <img src="@root/advent_04_215-resized.png" alt="cover art by Danielle Navarro" width="80%"/>
  </div>
  <div class="col-8">
    <p>
      Upon first encountering SQL after two decades of Fortran, C, Java, and Python,
      I thought I had stumbled into hell.
      I quickly realized that was optimistic:
      after all,
      hell has rules.
    </p>
    <p>
      I have since realized that SQL does too,
      and that they are no more confusing or contradictory than those of most other programming languages.
      They only appear so because it draws on a tradition unfamiliar to those of us raised with derivatives of C.
      To quote <a href="https://terrypratchett.com/">Terry Pratchett</a>,
      it is not mad, just differently sane.
    </p>
    <p>
      Welcome, then, to a world in which the strange will become familiar, and the familiar, strange.
      Welcome, thrice welcome, to SQL.
    </p>
    <p class="italic">
      "[% config "title" %]" is a <a href="[% config "author.site" %]">Third Bit</a> production.
    </p>
  </div>
</div>

<!-- ---------------------------------------------------------------- -->
[% section_start class="aside" title="What This Is" %]

-   Notes and working examples that instructors can use to perform a lesson
    -   Do *not* expect novices with no prior SQL experience to be able to learn from them
-   Musical analogy
    -   This is the chord changes and melody
    -   We expect instructors to create an arrangement and/or improvise while delivering
    -   See [*Teaching Tech Together*][t3] for background
-   Please see [the license](./license/) for terms of use,
    the [Code of Conduct](./conduct/) for community standards,
    and [these guidelines](./contributing/) for contributing
-   [Greg Wilson][wilson-greg] is a programmer, author, and educator based in Toronto

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Scope" %]

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

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Setup" %]

-   Download [the latest release]([% config "release" %])
-   Unzip the file in a temporary directory to create:
    -   `./db/*.db`: the [SQLite][sqlite] databases used in the examples
    -   `./src/*.*`: SQL queries, Python scripts, and other source code
    -   `./out/*.*`: expected output for examples

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Background Concepts" %]

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
   file="img/concept_map_overview.svg"
   title="overview of major concepts"
   alt="box and arrow concept map of major concepts related to databases"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Connecting to Database" %]

[% single "src/connect_penguins.sh" %]

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

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Selecting Constant" %]

[% multi "src/select_1.sql" "out/select_1.out" %]

-   `select` is a keyword
-   Normally used to select data from table…
-   …but if all we want is a constant value, we don't need to specify one
-   Semi-colon terminator is required

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Selecting All Values from Table" %]

[% multi "src/select_star.sql" "out/select_star.out" %]

-   An actual [%g query "query" %]
-   Use `*` to mean "all columns"
-   Use <code>from <em>tablename</em></code> to specify table
-   Output format is not particularly readable

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Administrative Commands" %]

[% multi "src/admin_commands.sql" "out/admin_commands.out" %]

-   `.mode markdown` and `.headers on` make the output more readable
-   These SQLite [%g admin_command "administrative commands" %]
    start with `.` and *aren't* part of the SQL standard
    -   PostgreSQL's special commands start with `\`
-   Each command must appear on a line of its own
-   Use `.help` for a complete list
-   And as mentioned earlier, use `.quit` to quit

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Specifying Columns" %]

[% multi "src/specify_columns.sql" "out/specify_columns.out" %]

-   Specify column names separated by commas
    -   In any order
    -   Duplicates allowed
-   Line breaks <strike>allowed</strike> encouraged for readability

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Sorting" %]

[% multi "src/sort.sql" "out/sort.out" %]

-   `order by` must follow `from` (which must follow `select`)
-   `asc` is ascending, `desc` is descending
    -   Default is ascending, but please specify

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a SQL query to select the sex and body mass columns from the `little_penguins` in that order,
sorted such that the largest body mass appears first.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Limiting Output" %]

-   Full dataset has 344 rows

[% multi "src/limit.sql" "out/limit.out" %]

-   Comments start with `--` and run to the end of the line
-   <code>limit <em>N</em></code> specifies maximum number of rows returned by query

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Paging Output" %]

[% multi "src/page.sql" "out/page.out" %]

-   <code>offset <em>N</em></code> must follow `limit`
-   Specifies number of rows to skip from the start of the selection
-   So this query skips the first 3 and shows the next 10

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Removing Duplicates" %]

[% multi "src/distinct.sql" "out/distinct.out" %]

-   `distinct` keyword must appear right after `select`
    -   SQL was supposed to read like English
-   Shows distinct combinations
-   Blanks in `sex` column show missing data
    -   We'll talk about this in a bit

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a SQL query to select the islands and species
from rows 50 to 60 inclusive of the `penguins` table.
Your result should have 11 rows.

[% exercise %]
Modify your query to select distinct combinations of island and species
from the same rows
and compare the result to what you got in part 1.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Filtering Results" %]

[% multi "src/filter.sql" "out/filter.out" %]

-   <code>where <em>condition</em></code> [%g filter "filters" %] the rows produced by selection
-   Condition is evaluated independently for each row
-   Only rows that pass the test appear in results
-   Use single quotes for `'text data'` and double quotes for `"weird column names"`
    -   SQLite will accept double-quoted text data but [SQLFluff][sqlfluff] will complain

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query to select the body masses from `penguins` that are less than 3000.0 grams.

[% exercise %]
Write another query to select the species and sex of penguins that weight less than 3000.0 grams.
This shows that the columns displayed and those used in filtering are independent of each other.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Filtering with More Complex Conditions" %]

[% multi "src/filter_and.sql" "out/filter_and.out" %]

-   `and`: both sub-conditions must be true
-   `or`: either or both part must be true
-   Notice that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test
    -   We'll talk about this in a bit

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use the `not` operator to select penguins that are *not* Gentoos.

[% exercise %]
SQL's `or` is an [%g inclusive_or "inclusive or" %]:
it succeeds if either *or both* conditions are true.
SQL does not provide a specific operator for [%g exclusive_or "exclusive or" %],
which is true if either *but not both* conditions are true,
but the same effect can be achieved using `and`, `or`, and `not`.
Write a query to select penguins that are female *or* on Torgersen Island *but not both*.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Doing Calculations" %]

[% multi "src/calculations.sql" "out/calculations.out" %]

-   Can do the usual kinds of arithmetic on individual values
    -   Calculation done for each row independently
-   Column name shows the calculation done

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Renaming Columns" %]

[% multi "src/rename_columns.sql" "out/rename_columns.out" %]

-   Use <code><em>expression</em> as <em>name</em></code> to rename
-   Give result of calculation a meaningful name
-   Can also rename columns without modifying

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a single query that calculates and returns:

1.  A column called `what_where` that has the species and island of each penguin
    separated by a single space.
2.  A column called `bill_ratio` that has the ratio of bill length to bill depth.

You can use the `||` operator to concatenate text to solve part 1,
or look at [the documentation for SQLite's `format()` function][sqlite_format].

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_select.svg"
   title="selection"
   alt="box and arrow diagram of concepts related to selection"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Calculating with Missing Values" %]

[% multi "src/show_missing_values.sql" "out/show_missing_values.out" %]

-   SQL uses a special value [%g null "<code>null</code>" %] to representing missing data
    -   Not 0 or empty string, but "I don't know"
-   Flipper length and body weight not known for one of the first five penguins
-   "I don't know" divided by 10 or 1000 is "I don't know"

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use SQLite's `.nullvalue` command
to change the printed representation of null to the string `null`
and then re-run the previous query.
When will displaying null as `null` be easier to understand?
When might it be misleading?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Null Equality" %]

-   Repeated from earlier (so it doesn't count against our query limit)

[% multi "src/filter.sql" "out/filter.out" %]

-   If we ask for female penguins the row with the missing sex drops out

[% multi "src/null_equality.sql" "out/null_equality.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Null Inequality" %]

-   But if we ask for penguins that *aren't* female it drops out as well

[% multi "src/null_inequality.sql" "out/null_inequality.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Ternary Logic" %]

[% multi "src/ternary_logic.sql" "out/ternary_logic.out" %]

-   If we don't know the left and right values, we don't know if they're equal or not
-   So the result is `null`
-   Get the same answer for `null != null`
-   [%g ternary_logic "Ternary logic" %]

<table>
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
</table>

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Handling Null Safely" %]

[% multi "src/safe_null_equality.sql" "out/safe_null_equality.out" %]

-   Use `is null` and `is not null` to handle null safely
-   Other parts of SQL handle nulls specially

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query to find penguins whose body mass is known but whose sex is not.

[% exercise %]
Write another query to find penguins whose sex is known but whose body mass is not.

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_null.svg"
   title="null"
   alt="box and arrow diagram of concepts related to null values in SQL"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Aggregating" %]

[% multi "src/simple_sum.sql" "out/simple_sum.out" %]

-   [%g aggregation "Aggregation" %] combines many values to produce one
-   `sum` is an [%g aggregation_func "aggregation function" %]
-   Combines corresponding values from multiple rows

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Common Aggregation Functions" %]

[% multi "src/common_aggregations.sql" "out/common_aggregations.out" %]

-   This actually shouldn't work:
    can't calculate maximum or average if any values are null
-   SQL does the useful thing instead of the right one

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
What is the average body mass of penguins that weight more than 3000.0 grams?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Counting" %]

[% multi "src/count_behavior.sql" "out/count_behavior.out" %]

-   `count(*)` counts rows
-   <code>count(<em>column</em>)</code> counts non-null entries in column
-   <code>count(distinct <em>column</em>)</code> counts distinct non-null entries

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
How many different body masses are in the penguins dataset?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Grouping" %]

[% multi "src/simple_group.sql" "out/simple_group.out" %]

-   Put rows in [%g group "groups" %] based on distinct combinations of values in columns specified with `group by`
-   Then perform aggregation separately for each group
-   But which is which?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Behavior of Unaggregated Columns" %]

[% multi "src/unaggregated_columns.sql" "out/unaggregated_columns.out" %]

-   All rows in each group have the same value for `sex`, so no need to aggregate

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Arbitrary Choice in Aggregation" %]

[% multi "src/arbitrary_in_aggregation.sql" "out/arbitrary_in_aggregation.out" %]

-   If we don't specify how to aggregate a column,
    SQLite chooses *any arbitrary value* from the group
    -   All penguins in each group have the same sex because we grouped by that, so we get the right answer
    -   The body mass values are in the data but unpredictable
    -   A common mistake
-   Other database managers don't do this
    -   E.g., PostgreSQL complains that column must be used in an aggregation function

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Explain why the output of the previous query
has a blank line before the rows for female and male penguins.

[% exercise %]
Write a query that shows each distinct body mass in the penguin dataset
and the number of penguins that weigh that much.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Filtering Aggregated Values" %]

[% multi "src/filter_aggregation.sql" "out/filter_aggregation.out" %]

-   Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Readable Output" %]

[% multi "src/readable_aggregation.sql" "out/readable_aggregation.out" %]

-   Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Filtering Aggregate Inputs" %]

[% multi "src/filter_aggregate_inputs.sql" "out/filter_aggregate_inputs.out" %]

-   <code>filter (where <em>condition</em>)</code> applies to *inputs*

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query that uses `filter` to calculate the average body masses
of heavy penguins (those over 4500 grams)
and light penguins (those under 3500 grams)
simultaneously.
Is it possible to do this using `where` instead of `filter`?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_aggregate.svg"
   title="aggregation"
   alt="box and arrow diagram of concepts related to aggregation in SQL"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Creating In-memory Database" %]

[% single "src/in_memory_db.sh" %]

-   "Connect" to an [%g in_memory_db "in-memory database" %]
    -   Changes aren't saved to disk
    -   Very useful for testing (discussed later)

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Creating Tables" %]

[% single "src/create_work_job.sql" %]

-   <code>create table <em>name</em></code> followed by parenthesized list of columns
-   Each column is a name, a data type, and optional extra information
    -   E.g., `not null` prevents nulls from being added
-   `.schema` is *not* standard SQL
-   SQLite has added a few things
    -   `create if not exists`
    -   upper-case keywords (SQL is case insensitive)

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Inserting Data" %]

[% multi "src/populate_work_job.sql" "out/insert_values.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Following Along" %]

-   To re-create this database:
    -   [Download the examples]([% config "release" %])
    -   Unzip that file
    -   `.read src/create_work_job.sql`
    -   `.read src/populate_work_job.sql`

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Using an in-memory database,
define a table called `notes` with two text columns `author` and `note`
and then add three or four rows.
Use a query to check that the notes have been stored
and that you can (for example) select by author name.

[% exercise %]
What happens if you try to insert too many or too few values into `notes`?
What happens if you insert a number instead of a string into the `note` field?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Updating Rows" %]

[% multi "src/update_work_job.sql" "out/update_rows.out" %]

-   (Almost) always specify row(s) to update using `where`
    -   Otherwise update all rows in table, which is usually not wanted

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Deleting Rows" %]

[% multi "src/delete_rows.sql" "out/delete_rows.out" %]

-   Again, (almost) always specify row(s) to delete using `where`

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
What happens if you try to delete rows that don't exist
(e.g., all entries in `work` that refer to `juna`)?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Backing Up" %]

[% multi "src/backing_up.sql" "out/backing_up.out" %]

-   We will explore another strategy based on [%g tombstone "tombstones" %] below

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
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

[% exercise %]
Saving and restoring data in binary format:

1.  Re-create the `notes` table in an in-memory database once again
    and use SQLite's `.backup` command to save it to a file called `notes.db`.
    Inspect this file using `od -c notes.db` or a text editor that can handle binary data:
    how has your data been stored?

2.  Start a fresh SQLite session
    and load `notes.db` using the `.restore` command.
    Inspect the database using `.schema` and `select *`:
    is everything as you expected?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_datamod.svg"
   title="data definition and modification"
   alt="box and arrow diagram of concepts relatd to defining and modifying data"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Combining Information" %]

[% multi "src/cross_join.sql" "out/cross_join.out" %]

-   A [%g join "join" %] combines information from two tables
-   [%g cross_join "cross join" %] constructs their cross product
    -   All combinations of rows from each
-   Result isn't particularly useful: `job` and `name` values don't match
    -   I.e., the combined data has records whose parts have nothing to do with each other

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Inner Join" %]

[% multi "src/inner_join.sql" "out/inner_join.out" %]

-   Use <code><em>table</em>.<em>column</em></code> notation to specify columns
    -   A column can have the same name as a table
-   Use <code>on <em>condition</em></code> to specify [%g join_condition "join condition" %]
-   Since `complain` doesn't appear in `job.name`, none of those rows are kept

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Re-run the query shown above using `where job = name` instead of the full `table.name` notation.
Is the shortened form easier or harder to read
and more or less likely to cause errors?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Aggregating Joined Data" %]

[% multi "src/aggregate_join.sql" "out/aggregate_join.out" %]

-   Combines ideas we've seen before
-   But Tay is missing from the table
    -   No records in the `job` table with `tay` as name
    -   So no records to be grouped and summed

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Left Join" %]

[% multi "src/left_join.sql" "out/left_join.out" %]

-   A [%g left_outer_join "left outer join" %] keeps all rows from the left table
-   Fills missing values from right table with null

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Aggregating Left Joins" %]

[% multi "src/aggregate_left_join.sql" "out/aggregate_left_join.out" %]

-   That's better, but we'd like to see 0 rather than a blank

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Coalescing Values" %]

[% multi "src/coalesce.sql" "out/coalesce.out" %]

-   <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Full Outer Join" %]

-   [%g full_outer_join "Full outer join" %] is the union of
    left outer join and [%g right_outer_join "right outer join" %]
-   Almost the same as cross join, but consider:

[% multi "src/full_outer_join.sql" "out/full_outer_join.out" %]

-   A cross join would produce empty result

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Find the least time each person spent on any job.
Your output should show that `mik` and `po` each spent 0.5 hours on some job.
Can you find a way to show the name of the job as well
using the SQL you have seen so far?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_join.svg"
   title="join"
   alt="box and arrow diagram of concepts related to joining tables"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Negating Incorrectly" %]

-   Who doesn't calibrate?

[% multi "src/negate_incorrectly.sql" "out/negate_incorrectly.out" %]

-   But Mik *does* calibrate
-   Problem is that there's an entry for Mik cleaning
-   And since `'clean' != 'calibrate'`, that row is included in the results
-   We need a different approach…

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Set Membership" %]

[% multi "src/set_membership.sql" "out/set_membership.out" %]

-   <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Subqueries" %]

[% multi "src/subquery_set.sql" "out/subquery_set.out" %]

-   Use a [%g subquery "subquery" %] to select the people who *do* calibrate
-   Then select all the people who *aren't* in that set
-   Initially feels odd, but subqueries are useful in other ways

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Defining a Primary Key" %]

-   Can use any field (or combination of fields) in a table as a [%g primary_key "primary key" %]
    as long as value(s) unique for each record
-   Uniquely identifies a particular record in a particular table

[% multi "src/primary_key.sql" "out/primary_key.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Does the `penguins` table have a primary key?
If so, what is it?
What about the `work` and `job` tables?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Autoincrementing and Primary Keys" %]

[% multi "src/autoincrement.sql" "out/autoincrement.out" %]

-   Database [%g autoincrement "autoincrements" %] `ident` each time a new record is added
-   Common to use that field as the primary key
    -   Unique for each record
-   If Mik changes their name again,
    we only have to change one fact in the database
-   Downside: manual queries are harder to read (who is person 17?)

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Internal Tables" %]

[% multi "src/sequence_table.sql" "out/sequence_table.out" %]

-   Sequence numbers are *not* reset when rows are deleted
    -   In part so that they can be used as primary keys

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Are you able to modify the values stored in `sqlite_sequence`?
In particular,
are you able to reset the values so that
the same sequence numbers are generated again?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Altering Tables" %]

[% multi "src/alter_tables.sql" "out/alter_tables.out" %]

-   Add a column after the fact
-   Since it can't be null, we have to provide a default value
    -   Really want to make it the primary key, but SQLite doesn't allow that after the fact
-   Then use `update` to modify existing records
    -   Can modify any number of records at once
    -   So be careful about `where` clause
-   An example of [%g data_migration "data migration" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="M-to-N Relationships" %]

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

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Creating New Tables from Old" %]

[% multi "src/insert_select.sql" "out/insert_select.out" %]

-   `new_work` is our join table
-   Each column refers to a record in some other table

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Removing Tables" %]

[% multi "src/drop_table.sql" "out/drop_table.out" %]

-   Remove the old table and rename the new one to take its place
    -   Note `if exists`
-   Please back up your data first

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Reorganize the penguins database:

1.  Make a copy of the `penguins.db` file
    so that your changes won't affect the original.

2.  Write a SQL script that reorganizes the data into three tables:
    one for each island.

3.  Why is organizing data like this a bad idea?

[% exercise %]
Tools like [Sqitch][sqitch] can manage changes to database schemas and data
so that they can be saved in version control
and rolled back if they are unsuccessful.
Translate the changes made by the scripts above into Sqitch.
Note: this exercise may take an hour or more.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Comparing Individual Values to Aggregates" %]

-   Go back to the original penguins database

[% multi "src/compare_individual_aggregate.sql" "out/compare_individual_aggregate.out" %]

-   Get average body mass in subquery
-   Compare each row against that
-   Requires two scans of the data, but no way to avoid that
    -   Except calculating a running total each time a penguin is added to the table
-   Null values aren't included in the average or in the final results

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use a subquery to find the number of penguins
that weigh the same as the lightest penguin.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Comparing Individual Values to Aggregates Within Groups" %]

[% multi "src/compare_within_groups.sql" "out/compare_within_groups.out" %]

-   Subquery runs first to create temporary table `averaged` with average mass per species
-   Join that with `penguins`
-   Filter to find penguins heavier than average within their species

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use a subquery to find the number of penguins
that weigh the same as the lightest penguin of the same sex and species.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Common Table Expressions" %]

[% multi "src/common_table_expressions.sql" "out/common_table_expressions.out" %]

-   Use [%g cte "common table expression" %] (CTE) to make queries clearer
    -   Nested subqueries quickly become difficult to understand
-   Database decides how to optimize

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Explaining Query Plans" %]

[% multi "src/explain_query_plan.sql" "out/explain_query_plan.out" %]

-   SQLite plans to scan every row of the table
-   It will build a temporary [%g b_tree "B-tree data structure" %] to group rows

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use a CTE to find
the number of penguins
that weigh the same as the lightest penguin of the same sex and species.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Enumerating Rows" %]

-   Every table has a special column called `rowid`

[% multi "src/rowid.sql" "out/rowid.out" %]

-   `rowid` is persistent within a session
    -   I.e., if we delete the first 5 rows we now have row IDs 6…N
-   *Do not rely on row ID*
    -   In particular, do not use it as a key

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
To explore how row IDs behave:

1.  Suppose that you create a new table,
    add three rows,
    delete those rows,
    and add the same values again.
    Do you expect the row IDs of the final rows to be 1–3 or 4–6?

2.  Using an in-memory database,
    perform the steps in part 1.
    Was the result what you expected?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Conditionals" %]

[% multi "src/if_else.sql" "out/if_else.out" %]

-   <code>iif(<em>condition</em>, <em>true_result</em>, <em>false_result</em>)</code>
    -   Note: `iif` with two i's
-   May feel odd to think of `if`/`else` as a function,
    but common in [%g vectorization "vectorized" %] calculations

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
How does the result of the previous query change
if the check for null body mass is removed?
Why is the result without that check misleading?

[% exercise %]
What does each of the expressions shown below produce?
Which ones do you think actually attempt to divide by zero?

1.  `iif(0, 123, 1/0)`
1.  `iif(1, 123, 1/0)`
1.  `iif(0, 1/0, 123)`
1.  `iif(1, 1/0, 123)`

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Selecting a Case" %]

-   What if we want small, medium, and large?
-   Can nest `iif`, but quickly becomes unreadable

[% multi "src/case_when.sql" "out/case_when.out" %]

-   Evaluate `when` options in order and take first
-   Result of `case` is null if no condition is true
-   Use `else` as fallback

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Modify the query above so that
the outputs are `"penguin is small"` and `"penguin is large"`
by concatenating the string `"penguin is "` to the entire `case`
rather than to the individual `when` branches.
(This exercise shows that `case`/`when` is an [%g expression "expression" %]
rather than a [%g statement "statement" %].)

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Checking a Range" %]

[% multi "src/check_range.sql" "out/check_range.out" %]

-   `between` can make queries easier to read
-   But be careful of the `and` in the middle

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
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

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Yet Another Database" %]

-   [%g er_diagram "Entity-relationship diagram" %] (ER diagram) shows relationships between tables
-   Like everything to do with databases, there are lots of variations

[% figure
   file="img/assays_tables.svg"
   title="assay database table diagram"
   alt="table-level diagram of assay database showing primary and foreign key relationships"
%]

[% figure
   file="img/assays_er.svg"
   title="assay ER diagram"
   alt="entity-relationship diagram showing logical structure of assay database"
%]

[% multi "src/assay_staff.sql" "out/assay_staff.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Draw a table diagram and an ER diagram to represent the following database:

-   `person` has `id` and `full_name`
-   `course` has `id` and `name`
-   `section` has `course_id`, `start_date`, and `end_date`
-   `instructor` has `person_id` and `section_id`
-   `student` has `person_id`, `section_id`, and `status`

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Pattern Matching" %]

[% multi "src/like_glob.sql" "out/like_glob.out" %]

-   `like` is the original SQL pattern matcher
    -   `%` matches zero or more characters at the start or end of a string
    -   Case insensitive by default
-   `glob` supports Unix-style wildcards

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Rewrite the pattern-matching query shown above using `glob`.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Selecting First and Last Rows" %]

[% multi "src/union_all.sql" "out/union_all.out" %]

-   `union all` combines records
    -   Keeps duplicates: `union` on its own only keeps unique records
    -   Which is more work but sometimes more useful
-   Yes, it feels like the extra `select * from` should be unnecessary

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query whose result includes two rows for each Adelie penguin
in the `penguins` database.
How can you check that your query is working correctly?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Intersection" %]

[% multi "src/intersect.sql" "out/intersect.out" %]

-   Rows involved must have the same structure
-   Intersection usually used when pulling values from different sources
    -   In the query above, would be clearer to use `where`

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use `intersect` to find all Adelie penguins that weigh more than 4000 grams.
How can you check that your query is working correctly?

[% exercise %]
Use `explain query plan` to compare the `intersect`-based query you just wrote
with one that uses `where`.
Which query looks like it will be more efficient?
Why do you believe this?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Exclusion" %]

[% multi "src/except.sql" "out/except.out" %]

-   Again, tables must have same structure
    -   And this would be clearer with `where`
-   SQL operates on sets, not tables, except where it doesn't

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Use `exclude` to find all Gentoo penguins that *aren't* male.
How can you check that your query is working correctly?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Random Numbers and Why Not" %]

[% multi "src/random_numbers.sql" "out/random_numbers.out" %]

-   There is no way to seed SQLite's random number generator
-   Which means there is no way to reproduce its pseudo-random sequences
-   Which means you should *never* use it
    -   How are you going to debug something you can't re-run?

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query that:

-   uses a CTE to create 1000 random numbers between 0 and 10 inclusive;

-   uses a second CTE to calculate their mean; and

-   uses a third CTE and [SQLite's built-in math functions][sqlite_math]
    to calculate their standard deviation.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Creating an Index" %]

[% multi "src/create_use_index.sql" "out/create_use_index.out" %]

-   An [%g index "index" %] is an auxiliary data structure that enables faster access to records
    -   Spend storage space to buy speed
-   Don't have to mention it explicitly in queries
    -   Database manager will use it automatically
-   Unlike primary keys, SQLite supports defining indexes after the fact

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Generating Sequences" %]

[% multi "src/generate_sequence.sql" "out/generate_sequence.out" %]

-   A (non-standard) [%g table_valued_func "table-valued function" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Generating Sequences Based on Data" %]

[% multi "src/data_range_sequence.sql" "out/data_range_sequence.out" %]

-   Must have the parentheses around the `min` and `max` selections to keep SQLite happy

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Generating Sequences of Dates" %]

[% multi "src/date_sequence.sql" "out/date_sequence.out" %]

-   SQLite represents dates as YYYY-MM-DD strings
    or as Julian days or as Unix milliseconds or…
    -   Julian days is fractional number of days since November 24, 4714 BCE
-   `julianday` and `date` convert back and forth
-   `julianday` is specific to SQLite
    -   Other databases have their own date handling functions

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Counting Experiments Started per Day Without Gaps" %]

[% multi "src/experiments_per_day.sql" "out/experiments_per_day.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
What does the expression `date('now', 'start of month', '+1 month', '-1 day')` produce?
(You may find [the documentation on SQLite's date and time functions][sqlite_datetime] helpful.)

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Self Join" %]

[% multi "src/self_join.sql" "out/self_join.out" %]

-   Join a table to itself
    -   Use `as` to create [%g alias "aliases" %] for copies of tables to distinguish them
    -   Nothing special about the names `left` and `right`
-   Get all <math>n<sup>2</sup></math> pairs, including person with themself

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Generating Unique Pairs" %]

[% multi "src/unique_pairs.sql" "out/unique_pairs.out" %]

-   `left.ident < right.ident` ensures distinct pairs without duplicates
    -   Query uses `left.ident <= 4 and right.ident <= 4` to shorten output
-   Quick check: <math>n(n-1)/2</math> pairs

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Filtering Pairs" %]

[% multi "src/filter_pairs.sql" "out/filter_pairs.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Existence and Correlated Subqueries" %]

[% multi "src/correlated_subquery.sql" "out/correlated_subquery.out" %]

-   Endocrinology is missing from the list
-   `select 1` could equally be `select true` or any other value
-   A [%g correlated_subquery "correlated subquery" %] depends on a value from the outer query
    -   Equivalent to nested loop

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Nonexistence" %]

[% multi "src/nonexistence.sql" "out/nonexistence.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Can you rewrite the previous query using `exclude`?
If so, is your new query easier to understand?
If the query cannot be rewritten, why not?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Avoiding Correlated Subqueries" %]

[% multi "src/avoid_correlated_subqueries.sql" "out/avoid_correlated_subqueries.out" %]

-   The join might or might not be faster than the correlated subquery
-   Hard to find unstaffed departments without either `not exists` or `count` and a check for 0

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Lead and Lag" %]

[% multi "src/lead_lag.sql" "out/lead_lag.out" %]

-   Use `strftime` to extract year and month
    -   Clumsy, but date/time handling is not SQLite's strong point
-   Use [%g window_func "window functions" %] `lead` and `lag` to shift values
    -   Unavailable values at the top or bottom are null

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Boundaries" %]

-   [Documentation on SQLite's window functions][sqlite_window] describes
    three frame types and five kinds of frame boundary
-   It feels very ad hoc, but so does the real world

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Windowing Functions" %]

[% multi "src/window_functions.sql" "out/window_functions.out" %]

-   `sum() over` does a running total
-   `cume_dist()` is fraction *of rows seen so far*
-   So `num_done` column is number of experiments done…
-   …`completed_progress` is the fraction of experiments done…
-   …and `linear_progress` is the fraction of time passed

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Explaining Another Query Plan" %]

[% multi "src/explain_window_function.sql" "out/explain_window_function.out" %]

-   Becomes useful…eventually

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Partitioned Windows" %]

[% multi "src/partition_window.sql" "out/partition_window.out" %]

-   `partition by` creates groups
-   So this counts experiments started since the beginning of each year

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Create a query that:

1.  finds the unique weights of the penguins in the `penguins` database;

2.  sorts them;

3.  finds the difference between each successive distinct weight; and

4.  counts how many times each unique difference appears.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Blobs" %]

[% multi "src/blob.sql" "out/blob.out" %]

-   A [%g blob "blob" %] is a binary large object
    -   Bytes in, bytes out…
-   If you think that's odd, check out [Fossil][fossil]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Modify the query shown above to select the value of `content`
rather than its length.
How intelligible is the output?
Does using SQLite's `hex()` function make it any more readable?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Yet Another Database" %]

[% single "src/lab_log_db.sh" %]
[% multi "src/lab_log_schema.sql" "out/lab_log_schema.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Storing JSON" %]

[% multi "src/json_in_table.sql" "out/json_in_table.out" %]

-   Store heterogeneous data as [%g json "JSON" %]-formatted text
    (with double-quoted strings)
    -   Database parses the text each time it is queried,
        so performance can be an issue
-   Can alternatively store as blob (`jsonb`)
    -   Can't view it directly
    -   But more efficient

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Select Fields from JSON" %]

[% multi "src/json_field.sql" "out/json_field.out" %]

-   Single arrow `->` returns JSON representation of result
-   Double arrow `->>` returns SQL text, integer, real, or null
-   Left side is column
-   Right side is [%g path_expression "path expression" %]
    -   Start with `$` (meaning "root")
    -   Fields separated by `.`

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query that selects the year from the `"refurbished"` field
of the JSON data associated with the Inphormex plate reader.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="JSON Array Access" %]

[% multi "src/json_array.sql" "out/json_array.out" %]

-   SQLite and other database managers have many [JSON manipulation functions][sqlite_json]
-   `json_array_length` gives number of elements in selected array
-   Subscripts start with 0
-   Characters outside 7-bit ASCII represented as Unicode escapes

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Unpacking JSON Arrays" %]

[% multi "src/json_unpack.sql" "out/json_unpack.out" %]

-   `json_each` is another table-valued function
-   Use <code>json_each.<em>name</em></code> to get properties of unpacked array

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query that counts how many times each person appears
in the first log entry associated with any piece of equipment.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Selecting the Last Element of an  Array" %]

[% multi "src/json_array_last.sql" "out/json_array_last.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Modifying JSON" %]

[% multi "src/json_modify.sql" "out/json_modify.out" %]

-   Updates the in-memory copy of the JSON, *not* the database record
-   Please use `json_quote` rather than trying to format JSON with string operations

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
As part of cleaning up the lab log database,
replace the machine names in the JSON records in `usage`
with the corresopnding machine IDs from the `machine` table.

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Refreshing the Penguins Database" %]

[% multi "src/count_penguins.sql" "out/count_penguins.out" %]

-   We will restore full database after each example

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Tombstones" %]

[% single "src/make_active.sql" %]
[% multi "src/active_penguins.sql" "out/active_penguins.out" %]

-   Use a [%g tombstone "tombstone" %] to mark (in)active records
-   Every query must now include it

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Importing CSV Data" %]

-   SQLite and most other database managers have tools for importing and exporting [%g csv "CSV" %]
-   In SQLite:
    -   Define table
    -   Import data
    -   Convert empty strings to nulls (if desired)
    -   Convert types from text to whatever (not shown below)

[% single "src/create_penguins.sql" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
What are the data types of the columns in the `penguins` table
created by the CSV import shown above?
How can you correct the ones that need correcting?

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Views" %]

[% multi "src/views.sql" "out/views.out" %]

-   A [%g view "view" %] is a saved query that other queries can invoke
-   View is re-run each time it's used
-   Like a CTE, but:
    -   Can be shared between queries
    -   Views came first
-   Some databases offer [%g materialized_view "materialized views" %]
    -   Update-on-demand temporary tables

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Create a view in the lab log database called `busy` with two columns:
`machine_id` and `total_log_length`.
The first column records the numeric ID of each machine;
the second shows the total number of log entries for that machine.

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_temp.svg"
   title="temporary tables"
   alt="box and arrow diagram showing different kinds of temporary 'tables' in SQL"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Hours Reminder" %]

[% multi "src/all_jobs.sql" "out/all_jobs.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Adding Checks" %]

[% multi "src/all_jobs_check.sql" "out/all_jobs_check.out" %]

-   `check` adds constraint to table
    -   Must produce a Boolean result
    -   Run each time values added or modified
-   But changes made before the error have taken effect

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Rewrite the definition of the `penguins` table to add the following constraints:

1.  `body_mass_g` must be null or non-negative.

2.  `island` must be one of `"Biscoe"`, `"Dream"`, or `"Torgersen"`.
    (Hint: the `in` operator will be useful here.)

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="ACID" %]

-   [%g atomic "Atomic" %]: change cannot be broken down into smaller ones (i.e., all or nothing)
-   [%g consistent "Consistent" %]: database goes from one consistent state to another
-   [%g isolated "Isolated" %]: looks like changes happened one after another
-   [%g durable "Durable" %]: if change takes place, it's still there after a restart

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Transactions" %]

[% multi "src/transaction.sql" "out/transaction.out" %]

-   Statements outside transaction execute and are committed immediately
-   Statement(s) inside transaction don't take effect until:
    -   `end transaction` (success)
    -   `rollback` (undo)
-   Can have any number of statements inside a transaction
-   But *cannot* nest transactions in SQLite
    -   Other databases support this

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Rollback in Constraints" %]

[% multi "src/rollback_constraint.sql" "out/rollback_constraint.out" %]

-   All of second `insert` rolled back as soon as error occurred
-   But first `insert` took effect

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Rollback in Statements" %]

[% multi "src/rollback_statement.sql" "out/rollback_statement.out" %]

-   Constraint is in table definition
-   Action is in statement

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Upsert" %]

[% multi "src/upsert.sql" "out/upsert.out" %]

-   [%g upsert "upsert" %] stands for "update or insert"
    -   Create if record doesn't exist
    -   Update if it does
-   Not standard SQL but widely implemented
-   Example also shows use of SQLite `.print` command

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Using the assay database,
write a query that adds or modifies people in the `staff` table as shown:

| personal | family | dept | age |
| -------- | ------ | ---- | --- |
| Pranay   | Khanna | mb   | 41  |
| Riaan    | Dua    | gen  | 23  |
| Parth    | Johel  | gen  | 27  |

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Normalization" %]

-   First [%g normal_form "normal form" %] (1NF):
    every field of every record contains one indivisible value.

-   Second normal form (2NF) and third normal form (3NF):
    every value in a record that isn't a key depends solely on the key,
    not on other values.

-   [%g denormalization "Denormalization" %]: explicitly store values that could be calculated on the fly
    -   To simplify queries and/or make processing faster

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Creating Triggers" %]

[% single "src/trigger_setup.sql" %]

-   A [%g trigger "trigger" %] automatically runs before or after a specified operation
-   Can have side effects (e.g., update some other table)
-   And/or implement checks (e.g., make sure other records exist)
-   Add processing overhead…
-   …but data is either cheap or correct, never both
-   Inside trigger, refer to old and new versions of record
    as <code>old.<em>column</em></code> and <code>new.<em>column</em></code>

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Trigger Not Firing" %]

[% multi "src/trigger_successful.sql" "out/trigger_successful.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Trigger Firing" %]

[% multi "src/trigger_firing.sql" "out/trigger_firing.out" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Using the penguins database:

1.  create a table called `species` with columns `name` and `count`; and

2.  define a trigger that increments the count associated with each species
    each time a new penguin is added to the `penguins` table.

Does your solution behave correctly when several penguins are added
by a single `insert` statement?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Represent Graphs" %]

[% single "src/lineage_setup.sql" %]
[% multi "src/represent_graph.sql" "out/represent_graph.out" %]

[% figure
   file="img/lineage.svg"
   title="lineage diagram"
   alt="box and arrow diagram showing who is descended from whom in the lineage database"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Write a query that uses a self join to find every person's grandchildren.

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Recursive Queries" %]

[% multi "src/recursive_lineage.sql" "out/recursive_lineage.out" %]

-   Use a [%g recursive_cte "recursive CTE" %] to create a temporary table (`descendent`)
-   [%g base_case "Base case" %] seeds this table
-   [%g recursive_case "Recursive case" %] relies on value(s) already in that table and external table(s)
-   `union all` to combine rows
    -   Can use `union` but that has lower performance (must check uniqueness each time)
-   Stops when the recursive case yields an empty row set (nothing new to add)
-   Then select the desired values from the CTE

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Modify the recursive query shown above to use `union` instead of `union all`.
Does this affect the result?
Why or why not?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Contact Tracing Database" %]

[% multi "src/contact_person.sql" "out/contact_person.out" %]
[% multi "src/contact_contacts.sql" "out/contact_contacts.out" %]

[% figure
   file="img/contact_tracing.svg"
   title="contact diagram"
   alt="box and line diagram showing who has had contact with whom"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Bidirectional Contacts" %]

[% multi "src/bidirectional.sql" "out/bidirectional.out" %]

-   Create a [%g temporary_table "temporary table" %] rather than using a long chain of CTEs
    -   Only lasts as long as the session (not saved to disk)
-   Duplicate information rather than writing more complicated query

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Updating Group Identifiers" %]

[% multi "src/update_group_ids.sql" "out/update_group_ids.out" %]

-   `new_ident` is minimum of own identifier and identifiers one step away
-   Doesn't keep people with no contacts

<!-- ---------------------------------------------------------------- -->
[% section_break class="topic" title="Recursive Labeling" %]

[% multi "src/recursive_labeling.sql" "out/recursive_labeling.out" %]

-   Use `union` instead of `union all` to prevent [%g infinite_recursion "infinite recursion" %]

<!-- ---------------------------------------------------------------- -->
[% section_break class="exercise" %]

[% exercise %]
Modify the query above to use `union all` instead of `union` to trigger infinite recursion.
How can you modify the query so that it stops at a certain depth
so that you can trace its output?

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Check Understanding" %]

[% figure
   file="img/concept_map_cte.svg"
   title="common table expressions"
   alt="box and arrow diagram showing concepts related to common table expressions in SQL"
%]

<!-- ---------------------------------------------------------------- -->
[% section_break class="aside" title="Appendices" %]

### Glossary

[% glossary %]

### Acknowledgments

This tutorial would not have been possible without:

-   [Andi Albrecht][albrecht-andi]'s [`sqlparse`][sqlparse] module
-   [Dimitri Fontaine][fontaine-dimitri]'s [*The Art of PostgreSQL*][art-postgresql]
-   David Rozenshtein's *The Essence of SQL* (now sadly out of print)

I would also like to thank the following for spotting issues, making suggestions, or submitting changes:

[% thanks %]

### Links

[% link_table %]
[% section_end %]
