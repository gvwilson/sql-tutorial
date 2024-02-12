---
home: true
---
{% include init_counters.md %}

> **2024-02-07: Exercises Needed**
>
> This tutorial needs (at least) 50 exercises.
> If you would like to propose one,
> please [submit an issue]({{site.data.tutorial.repo}}/issues)
> with the question you would ask and the SQL you would want the learner to write.
> It doesn't have to use the databases in the `db` folder,
> but that would make learners' lives easier.
> All contributions will be acknowledged in the lesson.
>
> Note: I'm asking for proposals partly because I'm lazy,
> but also because I know from experience that
> I often focus on a handful of things that I personally found challenging
> and overlook other topics.
> Asking for help is one way to compensate for those blind spots.

<!-- ---------------------------------------------------------------- -->
{% include section_start.md class="aside" title="What This Is" %}

-   notes and working examples that instructors can use to perform a lesson
    -   do *not* expect novices with no prior SQL experience to be able to learn from them
-   musical analogy
    -   this is the chord changes and melody
    -   we expect instructors to create an arrangement and/or improvise while delivering
    -   see [*Teaching Tech Together*][t3] for background
-   please see [the license](./license/) for terms of use,
    the [Code of Conduct](./conduct/) for community standards,
    and [these guidelines](./contributing/) for notes on contributing
-   about the author:
    [Greg Wilson][wilson-greg] is a programmer, author, and educator based in Toronto

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Scope" %}

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
{% include section_break.md class="aside" title="Setup" %}

-   Download [the latest release]({{site.data.tutorial.release}})
-   Unzip the file in a temporary directory to create:
    -   `./db/*.db`: the [SQLite][sqlite] databases used in the examples
    -   `./src/*.*`: SQL queries, Python scripts, and other source code
    -   `./out/*.*`: expected output for examples

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Background Concepts" %}

-   A <a href="#g:database">database</a> is a collection of data that can be searched and retrieved
-   A <a href="#g:dbms">database management system</a> (DBMS) is a program that manages a particular kind of database
-   Each DBMS stores data in its own way
    -   [SQLite][sqlite] stores each database in a single file
    -   [PostgreSQL][postgresql] spreads information across many files for higher performance
-   DBMS can be a library embedded in other programs ([SQLite][sqlite]) or a server ([PostgreSQL][postgresql])
-   A <a href="#g:rdbms">relational database management system</a> (RDBMS) stores data in tables and uses [SQL][sql] for queries
    -   Unfortunately, every RDBMS has its own dialect of SQL
-   There are also <a href="#g:nosql">NoSQL databases</a> like [MongoDB][mongodb] that don't use tables

![concept map: overview](./img/concept_map_overview.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Connecting to Database" %}

{% include single.md file="src/connect_penguins.sh" %}

-   Not actually a query: starts an interactive session
-   Alternative: provide a single query on the command line <code>sqlite3 <em>database</em> "<em>query</em>"</code>
-   Or put query in file and run <code>sqlite3 <em>database</em> < <em>filename</em></code>

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Selecting Constant" %}

{% include double.md stem="select_1" suffix="sql out" %}

-   `select` is a keyword
-   Normally used to select data from table…
-   …but if all we want is a constant value, we don't need to specify one
-   Semi-colon terminator is required

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Selecting All Values from Table" %}

{% include double.md stem="select_star" suffix="sql out" %}

-   An actual <a href="#g:query">query</a>
-   Use `*` to mean "all columns"
-   Use <code>from <em>tablename</em></code> to specify table
-   Output format is not particularly readable

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Administrative Commands" %}

{% include double.md stem="admin_commands" suffix="sql out" %}

-   [SQLite][sqlite] administrative commands start with `.` and *aren't* part of the SQL standard
    -   PostgreSQL's special commands start with `\`
-   Use `.help` for a complete list

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Specifying Columns" %}

{% include double.md stem="specify_columns" suffix="sql out" %}

-   Specify column names separated by commas
    -   In any order
    -   Duplicates allowed
-   Line breaks <strike>allowed</strike> encouraged for readability

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Sorting" %}

{% include double.md stem="sort" suffix="sql out" %}

-   `order by` must follow `from` (which must follow `select`)
-   `asc` is ascending, `desc` is descending
    -   Default is ascending, but please specify

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Write a SQL query to select the sex and body mass columns from the `little_penguins` in that order,
sorted such that the largest body mass appears first.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Limiting Output" %}

-   Full dataset has 344 rows

{% include double.md stem="limit" suffix="sql out" %}

-   Comments start with `--` and run to the end of the line
-   <code>limit <em>N</em></code> specifies maximum number of rows returned by query

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Paging Output" %}

{% include double.md stem="page" suffix="sql out" %}

-   <code>offset <em>N</em></code> must follow `limit`
-   Specifies number of rows to skip from the start of the selection
-   So this query skips the first 3 and shows the next 10

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Removing Duplicates" %}

{% include double.md stem="distinct" suffix="sql out" %}

-   `distinct` keyword must appear right after `select`
    -   SQL was supposed to read like English
-   Shows distinct combinations
-   Blanks in `sex` column show missing data
    -   We'll talk about this in a bit

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Write a SQL query to select the islands and species
from rows 50 to 60 inclusive of the `penguins` table.
Your result should have 11 rows.

{% include exercise.md %}
Modify your query to select distinct combinations of island and species
from the same rows
and compare the result to what you got in part 1.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Filtering Results" %}

{% include double.md stem="filter" suffix="sql out" %}

-   <code>where <em>condition</em></code> <a href="#g:filter">filters</a> the rows produced by selection
-   Condition is evaluated independently for each row
-   Only rows that pass the test appear in results
-   Use single quotes for `'text data'` and double quotes for `"weird column names"`
    -   [SQLite][sqlite] will accept double-quoted text data but [SQLFluff][sqlfluff] will complain

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Write a query to select the body masses from `penguins` that are less than 3000.0 grams.

{% include exercise.md %}
Write another query to select the species and sex of penguins that weight less than 3000.0 grams.
This shows that the columns displayed and those used in filtering are independent of each other.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Filtering with More Complex Conditions" %}

{% include double.md stem="filter_and" suffix="sql out" %}

-   `and`: both sub-conditions must be true
-   `or`: either or both part must be true
-   Notice that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test
    -   We'll talk about this in a bit

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Use the `not` operator to select penguins that are *not* Gentoos.

{% include exercise.md %}
SQL's `or` is an <a href="#g:inclusive_or">inclusive or</a>:
it succeeds if either *or both* conditions are true.
SQL does not provide a specific operator for <a href="#g:exclusive_or">exclusive or</a>,
which is true if either *but not both* conditions are true,
but the same effect can be achieved using `and`, `or`, and `not`.
Write a query to select penguins that are female *or* on Torgersen Island *but not both*.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Doing Calculations" %}

{% include double.md stem="calculations" suffix="sql out" %}

-   Can do the usual kinds of arithmetic on individual values
    -   Calculation done for each row independently
-   Column name shows the calculation done

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Renaming Columns" %}

{% include double.md stem="rename_columns" suffix="sql out" %}

-   Use <code><em>expression</em> as <em>name</em></code> to rename
-   Give result of calculation a meaningful name
-   Can also rename columns without modifying

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Write a single query that calculates and returns:

1.  A column called `what_where` that has the species and island of each penguin
    separated by a single space.
2.  A column called `bill_ratio` that has the ratio of bill length to bill depth.

You can use the `||` operator to concatenate text to solve part 1,
or look at [the documentation for SQLite's `format()` function][sqlite_format].

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: selection](./img/concept_map_select.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Calculating with Missing Values" %}

{% include double.md stem="show_missing_values" suffix="sql out" %}

-   SQL uses a special value <a href="#g:null"><code>null</code></a> to representing missing data
    -   Not 0 or empty string, but "I don't know"
-   Flipper length and body weight not known for one of the first five penguins
-   "I don't know" divided by 10 or 1000 is "I don't know"

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Use [SQLite][sqlite]'s `.nullvalue` command
to change the printed representation of null to the string `null`
and then re-run the previous query.
When will displaying null as `null` be easier to understand?
When might it be misleading?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Null Equality" %}

-   Repeated from earlier (so it doesn't count against our query limit)

{% include double.md stem="filter" suffix="sql out" %}

-   If we ask for female penguins the row with the missing sex drops out

{% include double.md stem="null_equality" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Null Inequality" %}

-   But if we ask for penguins that *aren't* female it drops out as well

{% include double.md stem="null_inequality" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Ternary Logic" %}

{% include double.md stem="ternary_logic" suffix="sql out" %}

-   If we don't know the left and right values, we don't know if they're equal or not
-   So the result is `null`
-   Get the same answer for `null != null`
-   <a href="#g:ternary_logic">Ternary logic</a>

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
{% include section_break.md class="topic" title="Handling Null Safely" %}

{% include double.md stem="safe_null_equality" suffix="sql out" %}

-   Use `is null` and `is not null` to handle null safely
-   Other parts of SQL handle nulls specially

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Write a query to find penguins whose body mass is known but whose sex is not.

{% include exercise.md %}
Write another query to find penguins whose sex is known but whose body mass is not.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: null](./img/concept_map_null.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Aggregating" %}

{% include double.md stem="simple_sum" suffix="sql out" %}

-   <a href="#g:aggregation">Aggregation</a> combines many values to produce one
-   `sum` is an <a href="#g:aggregation_func">aggregation function</a>
-   Combines corresponding values from multiple rows

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Common Aggregation Functions" %}

{% include double.md stem="common_aggregations" suffix="sql out" %}

-   This actually shouldn't work:
    can't calculate maximum or average if any values are null
-   SQL does the useful thing instead of the right one

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
What is the average body mass of penguins that weight more than 3000.0 grams?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Counting" %}

{% include double.md stem="count_behavior" suffix="sql out" %}

-   `count(*)` counts rows
-   <code>count(<em>column</em>)</code> counts non-null entries in column
-   <code>count(distinct <em>column</em>)</code> counts distinct non-null entries

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
How many different body masses are in the penguins dataset?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Grouping" %}

{% include double.md stem="simple_group" suffix="sql out" %}

-   Put rows in <a href="#g:group">groups</a> based on distinct combinations of values in columns specified with `group by`
-   Then perform aggregation separately for each group
-   But which is which?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Behavior of Unaggregated Columns" %}

{% include double.md stem="unaggregated_columns" suffix="sql out" %}

-   All rows in each group have the same value for `sex`, so no need to aggregate

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Arbitrary Choice in Aggregation" %}

{% include double.md stem="arbitrary_in_aggregation" suffix="sql out" %}

-   If we don't specify how to aggregate a column,
    [SQLite][sqlite] chooses *any arbitrary value* from the group
    -   All penguins in each group have the same sex because we grouped by that, so we get the right answer
    -   The body mass values are in the data but unpredictable
    -   A common mistake
-   Other database managers don't do this
    -   E.g., PostgreSQL complains that column must be used in an aggregation function

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Explain why the output of the previous query
has a blank line before the rows for female and male penguins.

{% include exercise.md %}
Write a query that shows each distinct body mass in the penguin dataset
and the number of penguins that weigh that much.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Filtering Aggregated Values" %}

{% include double.md stem="filter_aggregation" suffix="sql out" %}

-   Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Readable Output" %}

{% include double.md stem="readable_aggregation" suffix="sql out" %}

-   Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Filtering Aggregate Inputs" %}

{% include double.md stem="filter_aggregate_inputs" suffix="sql out" %}

-   <code>filter (where <em>condition</em>)</code> applies to *inputs*

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Write a query that uses `filter` to calculate the average body masses
of heavy penguins (those over 4500 grams)
and light penguins (those under 3500 grams)
simultaneously.
Is it possible to do this using `where` instead of `filter`?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: aggregation](./img/concept_map_aggregate.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Creating In-memory Database" %}

{% include single.md file="src/in_memory_db.sh" %}

-   "Connect" to an <a href="#g:in_memory_db">in-memory database</a>
    -   Changes aren't saved to disk
    -   Very useful for testing (discussed later)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Creating Tables" %}

{% include single.md file="src/create_work_job.sql" %}

-   <code>create table <em>name</em></code> followed by parenthesized list of columns
-   Each column is a name, a data type, and optional extra information
    -   E.g., `not null` prevents nulls from being added
-   `.schema` is *not* standard SQL
-   [SQLite][sqlite] has added a few things
    -   `create if not exists`
    -   upper-case keywords (SQL is case insensitive)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Inserting Data" %}

{% include single.md file="src/populate_work_job.sql" %}
{% include single.md file="out/insert_values.out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Following Along" %}

-   To re-create this database:
    -   [Download the examples]({{site.data.tutorial.release}})
    -   Unzip that file
    -   `.read src/create_work_job.sql`
    -   `.read src/populate_work_job.sql`

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Using an in-memory database,
define a table called `notes` with two text columns `author` and `note`
and then add three or four rows.
Use a query to check that the notes have been stored
and that you can (for example) select by author name.

{% include exercise.md %}
What happens if you try to insert too many or too few values into `notes`?
What happens if you insert a number instead of a string into the `note` field?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Updating Rows" %}

{% include single.md file="src/update_work_job.sql" %}
{% include single.md file="out/update_rows.out" %}

-   (Almost) always specify row(s) to update using `where`
    -   Otherwise update all rows in table, which is usually not wanted

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Deleting Rows" %}

{% include double.md stem="delete_rows" suffix="sql out" %}

-   Again, (almost) always specify row(s) to delete using `where`

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
What happens if you try to delete rows that don't exist
(e.g., all entries in `work` that refer to `juna`)?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Backing Up" %}

{% include double.md stem="backing_up" suffix="sql out" %}

-   We will explore another strategy based on <a href="#g:tombstone">tombstones</a> below

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Saving and restoring data as text:

1.  Re-create the `notes` table in an in-memory database
    and then use [SQLite][sqlite]'s `.output` and `.dump` commands
    to save the database to a file called `notes.sql`.
    Inspect the contents of this file:
    how has your data been stored?

2.  Start a fresh [SQLite][sqlite] session
    and load `notes.sql` using the `.read` command.
    Inspect the database using `.schema` and `select *`:
    is everything as you expected?

{% include exercise.md %}
Saving and restoring data in binary format:

1.  Re-create the `notes` table in an in-memory database once again
    and use [SQLite][sqlite]'s `.backup` command to save it to a file called `notes.db`.
    Inspect this file using `od -c notes.db` or a text editor that can handle binary data:
    how has your data been stored?

2.  Start a fresh [SQLite][sqlite] session
    and load `notes.db` using the `.restore` command.
    Inspect the database using `.schema` and `select *`:
    is everything as you expected?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: data definition and modification](./img/concept_map_datamod.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Combining Information" %}

{% include double.md stem="cross_join" suffix="sql out" %}

-   A <a href="#g:join">join</a> combines information from two tables
-   <a href="#g:cross_join">cross join</a> constructs their cross product
    -   All combinations of rows from each
-   Result isn't particularly useful: `job` and `name` values don't match
    -   I.e., the combined data has records whose parts have nothing to do with each other

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Inner Join" %}

{% include double.md stem="inner_join" suffix="sql out" %}

-   Use <code><em>table</em>.<em>column</em></code> notation to specify columns
    -   A column can have the same name as a table
-   Use <code>on <em>condition</em></code> to specify <a href="#g:join_condition">join condition</a>
-   Since `complain` doesn't appear in `job.name`, none of those rows are kept

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Re-run the query shown above using `where job = name` instead of the full `table.name` notation.
Is the shortened form easier or harder to read
and more or less likely to cause errors?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Aggregating Joined Data" %}

{% include double.md stem="aggregate_join" suffix="sql out" %}

-   Combines ideas we've seen before
-   But Tay is missing from the table
    -   No records in the `job` table with `tay` as name
    -   So no records to be grouped and summed

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Left Join" %}

{% include double.md stem="left_join" suffix="sql out" %}

-   A <a href="#g:left_outer_join">left outer join</a> keeps all rows from the left table
-   Fills missing values from right table with null

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Aggregating Left Joins" %}

{% include double.md stem="aggregate_left_join" suffix="sql out" %}

-   That's better, but we'd like to see 0 rather than a blank

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Coalescing Values" %}

{% include double.md stem="coalesce" suffix="sql out" %}

-   <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Full Outer Join" %}

-   <a href="#g:full_outer_join">Full outer join</a> is the union of
    left outer join and <a href="#g:right_outer_join">right outer join</a>
-   Almost the same as cross join, but consider:

{% include double.md stem="full_outer_join" suffix="sql out" %}

-   A cross join would produce empty result

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Find the least time each person spent on any job.
Your output should show that `mik` and `po` each spent 0.5 hours on some job.
Can you find a way to show the name of the job as well
using the SQL you have seen so far?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: join](./img/concept_map_join.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Negating Incorrectly" %}

-   Who doesn't calibrate?

{% include double.md stem="negate_incorrectly" suffix="sql out" %}

-   But Mik *does* calibrate
-   Problem is that there's an entry for Mik cleaning
-   And since `'clean' != 'calibrate'`, that row is included in the results
-   We need a different approach…

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Set Membership" %}

{% include double.md stem="set_membership" suffix="sql out" %}

-   <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Subqueries" %}

{% include double.md stem="subquery_set" suffix="sql out" %}

-   Use a <a href="#g:subquery">subquery</a> to select the people who *do* calibrate
-   Then select all the people who *aren't* in that set
-   Initially feels odd, but subqueries are useful in other ways

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Use a subquery to find the number of penguins
that weigh the same as the lightest penguin.

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Defining a Primary Key" %}

-   Can use any field (or combination of fields) in a table as a <a href="#g:primary_key">primary key</a>
    as long as value(s) unique for each record
-   Uniquely identifies a particular record in a particular table

{% include double.md stem="primary_key" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Does the `penguins` table have a primary key?
If so, what is it?
What about the `work` and `job` tables?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Autoincrementing and Primary Keys" %}

{% include double.md stem="autoincrement" suffix="sql out" %}

-   Database <a href="#g:autoincrement">autoincrements</a> `ident` each time a new record is added
-   Common to use that field as the primary key
    -   Unique for each record
-   If Mik changes their name again,
    we only have to change one fact in the database
-   Downside: manual queries are harder to read (who is person 17?)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Internal Tables" %}

{% include double.md stem="sequence_table" suffix="sql out" %}

-   Sequence numbers are *not* reset when rows are deleted
    -   In part so that they can be used as primary keys

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Are you able to modify the values stored in `sqlite_sequence`?
In particular,
are you able to reset the values so that
the same sequence numbers are generated again?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Altering Tables" %}

{% include double.md stem="alter_tables" suffix="sql out" %}

-   Add a column after the fact
-   Since it can't be null, we have to provide a default value
    -   Really want to make it the primary key, but [SQLite][sqlite] doesn't allow that after the fact
-   Then use `update` to modify existing records
    -   Can modify any number of records at once
    -   So be careful about `where` clause
-   An example of <a href="#g:data_migration">data migration</a>

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="M-to-N Relationships" %}

-   Relationships between entities are usually characterized as:
    -   <a href="#g:1_to_1">1-to-1</a>:
        fields in the same record
    -   <a href="#g:1_to_many">1-to-many</a>:
        the many have a <a href="#g:foreign_key">foreign key</a> referring to the one's primary key
    -   <a href="#g:many_to_many">many-to-many</a>:
        don't know how many keys to add to records ("maximum" never is)
-   Nearly-universal solution is a <a href="#g:join_table">join table</a>
    -   Each record is a pair of foreign keys
    -   I.e., each record is the fact that records A and B are related

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Creating New Tables from Old" %}

{% include double.md stem="insert_select" suffix="sql out" %}

-   `new_work` is our join table
-   Each column refers to a record in some other table

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Removing Tables" %}

{% include double.md stem="drop_table" suffix="sql out" %}

-   Remove the old table and rename the new one to take its place
    -   Note `if exists`
-   Please back up your data first

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="exercise" %}

{% include exercise.md %}
Tools like [Sqitch][sqitch] can manage changes to database schemas and data
so that they can be saved in version control
and rolled back if they are unsuccessful.
Translate the changes made by the scripts above into [Sqitch][sqitch].

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Comparing Individual Values to Aggregates" %}

-   Go back to penguins

{% include double.md stem="compare_individual_aggregate" suffix="sql out" %}

-   Get average body mass in subquery
-   Compare each row against that
-   Requires two scans of the data, but there's no way to avoid that
-   Null values aren't included in the average or in the final results

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Comparing Individual Values to Aggregates Within Groups" %}

{% include double.md stem="compare_within_groups" suffix="sql out" %}

-   Subquery runs first to create temporary table `averaged` with average mass per species
-   Join that with `penguins`
-   Filter to find penguins heavier than average within their species

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Common Table Expressions" %}

{% include double.md stem="common_table_expressions" suffix="sql out" %}

-   Use <a href="#g:cte">common table expression</a> (CTE) to make queries clearer
    -   Nested subqueries quickly become difficult to understand
-   Database decides how to optimize

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Explaining Query Plans" %}

{% include double.md stem="explain_query_plan" suffix="sql out" %}

-   [SQLite][sqlite] plans to scan every row of the table
-   It will build a temporary B-tree data structure to group rows

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Enumerating Rows" %}

-   Every table has a special column called `rowid`

{% include double.md stem="rowid" suffix="sql out" %}

-   `rowid` is persistent within a session
    -   I.e., if we delete the first 5 rows we now have row IDs 6…N
-   *Do not rely on row ID*
    -   In particular, do not use it as a key

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Conditionals" %}

{% include double.md stem="if_else" suffix="sql out" %}

-   <code>iif(<em>condition</em>, <em>true_result</em>, <em>false_result</em>)</code>
    -   Note: `iif` with two i's

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Selecting a Case" %}

-   What if we want small, medium, and large?
-   Can nest `iif`, but quickly becomes unreadable

{% include double.md stem="case_when" suffix="sql out" %}

-   Evaluate `when` options in order and take first
-   Result of `case` is null if no condition is true
-   Use `else` as fallback

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Checking a Range" %}

{% include double.md stem="check_range" suffix="sql out" %}

-   `between` can make queries easier to read
-   But be careful of the `and` in the middle

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Yet Another Database" %}

-   <a href="#g:er_diagram">Entity-relationship diagram</a> (ER diagram) shows relationships between tables
-   Like everything to do with databases, there are lots of variations

![assay database table diagram](./img/assays_tables.svg)

![assay ER diagram](./img/assays_er.svg)

{% include double.md stem="assay_staff" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Pattern Matching" %}

{% include double.md stem="like_glob" suffix="sql out" %}

-   `like` is the original SQL pattern matcher
    -   `%` matches zero or more characters at the start or end of a string
    -   Case insensitive by default
-   `glob` supports Unix-style wildcards

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
{% include section_break.md class="topic" title="Selecting First and Last Rows" %}

{% include double.md stem="union_all" suffix="sql out" %}

-   `union all` combines records
    -   Keeps duplicates: `union` on its own keeps unique records
-   Yes, it feels like the extra `select * from` should be unnecessary

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Intersection" %}

{% include double.md stem="intersect" suffix="sql out" %}

-   Tables being intersected must have same structure
-   Intersection usually used when pulling values from different tables
    -   In this case, would be clearer to use `where`

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Exclusion" %}

{% include double.md stem="except" suffix="sql out" %}

-   Again, tables must have same structure
    -   And this would be clearer with `where`
-   SQL operates on sets, not tables, except where it doesn't

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Random Numbers and Why Not" %}

{% include double.md stem="random_numbers" suffix="sql out" %}

-   There is no way to seed [SQLite][sqlite]'s random number generator
-   Which means there is no way to reproduce one of its "random" sequences

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Creating an Index" %}

{% include double.md stem="create_use_index" suffix="sql out" %}

-   An <a href="#g:index">index</a> is an auxiliary data structure that enables faster access to records
    -   Spend storage space to buy speed
-   Don't have to mention it explicitly in queries
    -   Database manager will use it automatically

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Generating Sequences" %}

{% include double.md stem="generate_sequence" suffix="sql out" %}

-   A (non-standard) <a href="#g:table_valued_func">table-valued function</a>

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Generating Sequences Based on Data" %}

{% include double.md stem="data_range_sequence" suffix="sql out" %}

-   Must have the parentheses around the `min` and `max` selections to keep [SQLite][sqlite] happy

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Generating Sequences of Dates" %}

{% include double.md stem="date_sequence" suffix="sql out" %}

-   [SQLite][sqlite] represents dates as YYYY-MM-DD strings
    or as Julian days or as Unix milliseconds or…
    -   Julian days is fractional number of days since November 24, 4714 BCE
-   `julianday` and `date` convert back and forth

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Counting Experiments Started per Day Without Gaps" %}

{% include double.md stem="experiments_per_day" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Self Join" %}

{% include double.md stem="self_join" suffix="sql out" %}

-   Join a table to itself
    -   Use `as` to create <a href="#g:alias">aliases</a> for copies of tables to distinguish them
    -   Nothing special about the names `left` and `right`
-   Get all <math>n<sup>2</sup></math> pairs, including person with themself

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Generating Unique Pairs" %}

{% include double.md stem="unique_pairs" suffix="sql out" %}

-   `left.ident < right.ident` ensures distinct pairs without duplicates
-   Use `left.ident <= 4 and right.ident <= 4` to limit output
-   Quick check: <math>n(n-1)/2</math> pairs

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Filtering Pairs" %}

{% include double.md stem="filter_pairs" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Existence and Correlated Subqueries" %}

{% include double.md stem="correlated_subquery" suffix="sql out" %}

-   Nobody works in Endocrinology
-   `select 1` could equally be `select true` or any other value
-   A <a href="#g:correlated_subquery">correlated subquery</a> depends on a value from the outer query
    -   Equivalent to nested loop

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Nonexistence" %}

{% include double.md stem="nonexistence" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Avoiding Correlated Subqueries" %}

{% include double.md stem="avoid_correlated_subqueries" suffix="sql out" %}

-   The join might or might not be faster than the correlated subquery
-   Hard to find unstaffed departments without either `not exists` or `count` and a check for 0

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Lead and Lag" %}

{% include double.md stem="lead_lag" suffix="sql out" %}

-   Use `strftime` to extract year and month
    -   Clumsy, but date/time handling is not [SQLite][sqlite]'s strong point
-   Use <a href="#g:window_func">window functions</a> `lead` and `lag` to shift values
    -   Unavailable values are null

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Windowing Functions" %}

{% include double.md stem="window_functions" suffix="sql out" %}

-   `sum() over` does a running total
-   `cume_dist` is fraction *of rows seen so far*

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Explaining Another Query Plan" %}

{% include double.md stem="explain_window_function" suffix="sql out" %}

-   Becomes useful…eventually

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Partitioned Windows" %}

{% include double.md stem="partition_window" suffix="sql out" %}

-   `partition by` creates groups
-   So this counts experiments started since the beginning of each year

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Blobs" %}

{% include double.md stem="blob" suffix="sql out" %}

-   A <a href="#g:blob">blob</a> is a binary large object
    -   Bytes in, bytes out…
-   If you think that's odd, check out [Fossil][fossil]

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Yet Another Database" %}

{% include single.md file="src/lab_log_db.sh" %}
{% include double.md stem="lab_log_schema" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Storing JSON" %}

{% include double.md stem="json_in_table" suffix="sql out" %}

-   Store heterogeneous data as JSON-formatted text (with double-quoted strings)
    -   Database parses it each time it is queried
-   Alternatively store as blob
    -   Can't just view it
    -   But more efficient

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Select Fields from JSON" %}

{% include double.md stem="json_field" suffix="sql out" %}

-   Single arrow `->` returns JSON representation result
-   Double arrow `->>` returns SQL text, integer, real, or null
-   Left side is column
-   Right side is <a href="#g:path_expression">path expression</a>
    -   Start with `$` (meaning "root")
    -   Fields separated by `.`

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="JSON Array Access" %}

{% include double.md stem="json_array" suffix="sql out" %}

-   [SQLite][sqlite] (and other database managers) has lots of JSON manipulation functions
-   `json_array_length` gives number of elements in selected array
-   subscripts start with 0
-   Characters outside 7-bit ASCII represented as Unicode escapes

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Unpacking JSON Arrays" %}

{% include double.md stem="json_unpack" suffix="sql out" %}

-   `json_each` is another table-valued function
-   Use <code>json_each.<em>name</em></code> to get properties of unpacked array

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Selecting the Last Element of an  Array" %}

{% include double.md stem="json_array_last" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Modifying JSON" %}

{% include double.md stem="json_modify" suffix="sql out" %}

-   Updates the in-memory copy of the JSON, *not* the database record
-   Please use `json_quote` rather than trying to format JSON with string operations

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Refreshing the Penguins Database" %}

{% include double.md stem="count_penguins" suffix="sql out" %}

-   We will restore full database after each example

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Tombstones" %}

{% include single.md file="src/make_active.sql" %}
{% include double.md stem="active_penguins" suffix="sql out" %}

-   Use a <a href="#g:tombstone">tombstone</a> to mark (in)active records
-   Every query must now include it

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Importing CSV Data" %}

-   [SQLite][sqlite] and most other database managers have tools for importing and exporting <a href="#g:csv">CSV</a>
-   In [SQLite][sqlite]:
    -   Define table
    -   Import data
    -   Convert empty strings to nulls (if desired)
    -   Convert types from text to whatever (not shown below)

{% include single.md file="src/create_penguins.sql" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Views" %}

{% include double.md stem="views" suffix="sql out" %}

-   A <a href="#g:view">view</a> is a saved query that other queries can invoke
-   View is re-run each time it's used
-   Like a CTE, but:
    -   Can be shared between queries
    -   Views came first
-   Some databases offer <a href="#g:materialized_view">materialized views</a>
    -   Update-on-demand temporary tables

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: temporary tables](./img/concept_map_temp.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Hours Reminder" %}

{% include double.md stem="all_jobs" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Adding Checks" %}

{% include double.md stem="all_jobs_check" suffix="sql out" %}

-   `check` adds constraint to table
    -   Must produce a Boolean result
    -   Run each time values added or modified
-   But changes made before the error have taken effect

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="ACID" %}

-   <a href="#g:atomic">Atomic</a>: change cannot be broken down into smaller ones (i.e., all or nothing)
-   <a href="#g:consistent">Consistent</a>: database goes from one consistent state to another
-   <a href="#g:isolated">Isolated</a>: looks like changes happened one after another
-   <a href="#g:durable">Durable</a>: if change takes place, it's still there after a restart

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Transactions" %}

{% include double.md stem="transaction" suffix="sql out" %}

-   Statements outside transaction execute and are committed immediately
-   Statement(s) inside transaction don't take effect until:
    -   `end transaction` (success)
    -   `rollback` (undo)
-   Can have any number of statements inside a transaction
-   But *cannot* nest transactions in [SQLite][sqlite]
    -   Other databases support this

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Rollback in Constraints" %}

{% include double.md stem="rollback_constraint" suffix="sql out" %}

-   All of second `insert` rolled back as soon as error occurred
-   But first `insert` took effect

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Rollback in Statements" %}

{% include double.md stem="rollback_statement" suffix="sql out" %}

-   Constraint is in table definition
-   Action is in statement

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Upsert" %}

{% include double.md stem="upsert" suffix="sql out" %}

-   <a href="#g:upsert">upsert</a> stands for "update or insert"
    -   Create if record doesn't exist
    -   Update if it does
-   Not standard SQL but widely implemented
-   Example also shows use of [SQLite][sqlite] `.print` command

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Normalization" %}

-   First <a href="#g:normal_form">normal form</a> (1NF):
    every field of every record contains one indivisible value.

-   Second normal form (2NF) and third normal form (3NF):
    every value in a record that isn't a key depends solely on the key,
    not on other values.

-   <a href="#g:denormalization">Denormalization</a>: explicitly store values that could be calculated on the fly
    -   To simplify queries and/or make processing faster

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Creating Triggers" %}

-   A <a href="#g:trigger">trigger</a> automatically runs before or after a specified operation
-   Can have side effects (e.g., update some other table)
-   And/or implement checks (e.g., make sure other records exist)
-   Add processing overhead…
-   …but data is either cheap or correct, never both
-   Inside trigger, refer to old and new versions of record
    as <code>old.<em>column</em></code> and <code>new.<em>column</em></code>

{% include single.md file="src/trigger_setup.sql" %}
{% include double.md stem="trigger_successful" suffix="sql out" %}

</section>
<section markdown="1">

# 081: trigger firing

{% include double.md stem="trigger_firing" suffix="sql out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Represent Graphs" %}

{% include single.md file="src/lineage_setup.sql" %}
{% include double.md stem="represent_graph" suffix="sql out" %}

![lineage diagram](./img/lineage.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Recursive Queries" %}

{% include double.md stem="recursive_lineage" suffix="sql out" %}

-   Use a <a href="#g:recursive_cte">recursive CTE</a> to create a temporary table (`descendent`)
-   <a href="#g:base_case">Base case</a> seeds this table
-   <a href="#g:recursive_case">Recursive case</a> relies on value(s) already in that table and external table(s)
-   `union all` to combine rows
    -   Can use `union` but that has lower performance (must check uniqueness each time)
-   Stops when the recursive case yields an empty row set (nothing new to add)
-   Then select the desired values from the CTE

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Contact Tracing Database" %}

{% include double.md stem="contact_person" suffix="sql out" %}
{% include double.md stem="contact_contacts" suffix="sql out" %}

![contact diagram](./img/contact_tracing.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Bidirectional Contacts" %}

{% include double.md stem="bidirectional" suffix="sql out" %}

-   Create a <a href="#g:temporary_table">temporary table</a> rather than using a long chain of CTEs
    -   Only lasts as long as the session (not saved to disk)
-   Duplicate information rather than writing more complicated query

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Updating Group Identifiers" %}

{% include double.md stem="update_group_ids" suffix="sql out" %}

-   `new_ident` is minimum of own identifier and identifiers one step away
-   Doesn't keep people with no contacts

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Recursive Labeling" %}

{% include double.md stem="recursive_labeling" suffix="sql out" %}

-   Use `union` instead of `union all` to prevent <a href="#g:infinite_recursion">infinite recursion</a>

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Check Understanding" %}

![concept map: common table expressions](./img/concept_map_cte.svg)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Querying from Python" %}

{% include double.md stem="basic_python_query" suffix="py out" %}

-   `sqlite3` is part of Python's standard library
-   Create a connection to a database file
-   Get a <a href="#g:cursor">cursor</a> by executing a query
    -   More common to create cursor and use that to run queries
-   Fetch all rows at once as list of tuples

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Incremental Fetch" %}

{% include double.md stem="incremental_fetch" suffix="py out" %}

-   `cursor.fetchone` returns `None` when no more data
-   There is also `fetchmany(N)` to fetch (up to) a certain number of rows

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Insert, Delete, and All That" %}

{% include double.md stem="insert_delete" suffix="py out" %}

-   Each `execute` is its own transaction

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Interpolating Values" %}

{% include double.md stem="interpolate" suffix="py out" %}

-   From [XKCD][xkcd-tables]

![XKCD Exploits of a Mom](./img/xkcd_327_exploits_of_a_mom.png)

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Script Execution" %}

{% include double.md stem="script_execution" suffix="py out" %}

-   But what if something goes wrong?

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="SQLite Exceptions in Python" %}

{% include double.md stem="exceptions" suffix="py out" %}

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Python in SQLite" %}

{% include double.md stem="embedded_python" suffix="py out" %}

-   [SQLite][sqlite] calls back into Python to execute the function
-   Other databases can run Python (and other languages) in the database server process
-   Be careful

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Handling Dates and Times" %}

{% include double.md stem="dates_times" suffix="py out" %}

-   `sqlite3.PARSE_DECLTYPES` tells `sqlite3` library to use converts based on declared column types
-   Adapt on the way in, convert on the way out

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="SQL in Jupyter Notebooks" %}

{% include single.md file="src/install_jupysql.sh" %}

-   And then inside the notebook:

{% include single.md file="src/load_ext.text" %}

-   Loads extension

{% include double.md stem="jupyter_connect" suffix="text out" %}

-   Connects to database
    -   `sqlite://` with two slashes is the protocol
    -   `/data/penguins.db` (one leading slash) is a local path
-   Single percent sign `%sql` introduces one-line command
-   Use double percent sign `%%sql` to indicate that the rest of the cell is SQL

{% include double.md stem="jupyter_select" suffix="text out" %}

<table>
  <thead>
    <tr>
      <th>species</th>
      <th>num</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Adelie</td>
      <td>152</td>
    </tr>
    <tr>
      <td>Chinstrap</td>
      <td>68</td>
    </tr>
    <tr>
      <td>Gentoo</td>
      <td>124</td>
    </tr>
  </tbody>
</table>

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Pandas and SQL" %}

{% include single.md file="src/install_pandas.sh" %}
{% include double.md stem="select_pandas" suffix="py out" %}

-   Be careful about datatype conversion when using [Pandas][pandas]

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Polars and SQL" %}

{% include single.md file="src/install_polars.sh" %}
{% include double.md stem="select_polars" suffix="py out" %}

-   The <a href="#g:uri">Uniform Resource Identifier</a> (URI) specifies the database
-   The query is the query
-   Use the ADBC engine instead of the default ConnectorX with [Polars][polars]

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Object-Relational Mappers" %}

{% include double.md stem="orm" suffix="py out" %}

-   An <a href="#g:orm">object-relational mapper</a> (ORM) translates table columns to object properties and vice versa
-   SQLModel relies on Python type hints

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="topic" title="Relations with ORMs" %}

{% include double.md stem="orm_relation" suffix="py out" %}

-   Make foreign keys explicit in class definitions
-   SQLModel automatically does the join
    -   The two staff with no department aren't included in the result

<!-- ---------------------------------------------------------------- -->
{% include section_break.md class="aside" title="Appendices" %}

### Terms

{% include glossary.html %}

### Acknowledgments

This tutorial would not have been possible without:

-   [Andi Albrecht][albrecht-andi]'s [`sqlparse`][sqlparse] module
-   [Dimitri Fontaine][fontaine-dimitri]'s [*The Art of PostgreSQL*][art-postgresql]
-   David Rozenshtein's *The Essence of SQL* (now sadly out of print)

I would also like to thank the following for spotting issues, making suggestions, or submitting changes:

{% include thanks.html %}

{% include section_end.md %}

{% include links.md links=site.data.links %}
