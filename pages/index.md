<div class="row">
  <div class="col-6 center">
    <img src="@root/cthulhu-300x253.jpg" alt="stylized Cthulhu"/>
  </div>
  <div class="col-6">
    <p>
      <a href="[% config 'repo' %]/issues/"><strong>The Querynomicon Needs Your Help</strong></a>
    </p>
    <ol>
      <li>
        <p><em>More exercises</em> to help learners practice.</p>
      </li>
      <li>
        <p><em>Sample solutions</em> so that they can check their work.</p>
      </li>
      <li>
        <p><em>CSS show/hide for solutions</em> because He Who Lies Dreaming said, "No JavaScript."</p>
      </li>
      <li>
        <p><em>Ideas for <a href="https://github.com/gvwilson/sys-tutorial/issues/1">the next tutorial</a></em> because why stop learning now?</p>
      </li>
    </ol>
  </div>
</div>

> Upon first encountering SQL after two decades of Fortran, C, Java, and Python,
> I thought I had stumbled into hell.
> I quickly realized that was optimistic:
> after all,
> hell has rules.
>
> I have since realized that SQL does too,
> and that they are no more confusing or contradictory than those of most other programming languages.
> They only appear so because it draws on a tradition unfamiliar to those of us raised with derivatives of C.
> To quote <a href="https://terrypratchett.com/">the other bard</a>,
> it is not mad, just differently sane.
>
> Welcome, then, to a world in which the strange will become familiar, and the familiar, strange.
> Welcome, thrice welcome, to SQL.

<!-- ---------------------------------------------------------------- -->

[% section_start class="aside" title="What This Is" %]

- notes and working examples that instructors can use to perform a lesson
  - do _not_ expect novices with no prior SQL experience to be able to learn from them
- musical analogy
  - this is the chord changes and melody
  - we expect instructors to create an arrangement and/or improvise while delivering
  - see [_Teaching Tech Together_][t3] for background
- please see [the license](./license/) for terms of use,
  the [Code of Conduct](./conduct/) for community standards,
  and [these guidelines](./contributing/) for notes on contributing
- about the author:
  [Greg Wilson][wilson-greg] is a programmer, author, and educator based in Toronto

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Scope" %]

- [intended audience][persona]
  - Rachel has a master's degree in cell biology
    and now works in a research hospital doing cell assays.
  - She learned a bit of R in an undergrad biostatistics course
    and has been through [the Carpentries lesson on the Unix shell][carpentries-shell].
  - Rachel is thinking about becoming a data scientist
    and would like to understand how data is stored and managed.
  - Her work schedule is unpredictable and highly variable,
    so she needs to be able to learn a bit at a time.
- prerequisites
  - basic Unix command line: `cd`, `ls`, `*` wildcard
  - basic tabular data analysis: filtering rows, aggregating within groups
- learning outcomes
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

- Download [the latest release]([% config "release" %])
- Unzip the file in a temporary directory to create:
  - `./db/*.db`: the [SQLite][sqlite] databases used in the examples
  - `./src/*.*`: SQL queries, Python scripts, and other source code
  - `./out/*.*`: expected output for examples

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Background Concepts" %]

- A <a href="#g:database">database</a> is a collection of data that can be searched and retrieved
- A <a href="#g:dbms">database management system</a> (DBMS) is a program that manages a particular kind of database
- Each DBMS stores data in its own way
  - SQLite stores each database in a single file
  - [PostgreSQL][postgresql] spreads information across many files for higher performance
- DBMS can be a library embedded in other programs (SQLite) or a server (PostgreSQL)
- A <a href="#g:rdbms">relational database management system</a> (RDBMS) stores data in tables and uses [SQL][sql] for queries
  - Unfortunately, every RDBMS has its own dialect of SQL
- There are also <a href="#g:nosql">NoSQL databases</a> like [MongoDB][mongodb] that don't use tables

[% figure
file="img/concept_map_overview.svg"
title="overview of major concepts"
alt="box and arrow concept map of major concepts related to databases"
%]

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Connecting to Database" %]

[% single "src/connect_penguins.sh" %]

- Not actually a query: starts an interactive session
- Alternative: provide a single query on the command line <code>sqlite3 <em>database</em> "<em>query</em>"</code>
- Or put query in file and run <code>sqlite3 <em>database</em> < <em>filename</em></code>
- To disconnect from the database, type a semicolon to throw an error to get out of `...>` and then type `.quit`
  <!-- ---------------------------------------------------------------- -->
  [% section_break class="topic" title="Selecting Constant" %]

[% double stem="select_1" suffix="sql out" %]

- `select` is a keyword
- Normally used to select data from table…
- …but if all we want is a constant value, we don't need to specify one
- Semi-colon terminator is required

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Selecting All Values from Table" %]

[% double stem="select_star" suffix="sql out" %]

- An actual <a href="#g:query">query</a>
- Use `*` to mean "all columns"
- Use <code>from <em>tablename</em></code> to specify table
- Output format is not particularly readable

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Administrative Commands" %]

[% double stem="admin_commands" suffix="sql out" %]

- SQLite administrative commands start with `.` and _aren't_ part of the SQL standard
  - PostgreSQL's special commands start with `\`
- Use `.help` for a complete list
- Now the outputted table is more readable
  [% double stem="select_star" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Specifying Columns" %]

[% double stem="specify_columns" suffix="sql out" %]

- Specify column names separated by commas
  - In any order
  - Duplicates allowed
- Line breaks <strike>allowed</strike> encouraged for readability

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Sorting" %]

[% double stem="sort" suffix="sql out" %]

- `order by` must follow `from` (which must follow `select`)
- `asc` is ascending, `desc` is descending
  - Default is ascending, but please specify

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a SQL query to select the sex and body mass columns from the `little_penguins` in that order,
sorted such that the largest body mass appears first.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Limiting Output" %]

- Full dataset has 344 rows

[% double stem="limit" suffix="sql out" %]

- Comments start with `--` and run to the end of the line
- <code>limit <em>N</em></code> specifies maximum number of rows returned by query

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Paging Output" %]

[% double stem="page" suffix="sql out" %]

- <code>offset <em>N</em></code> must follow `limit`
- Specifies number of rows to skip from the start of the selection
- So this query skips the first 3 and shows the next 10

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Removing Duplicates" %]

[% double stem="distinct" suffix="sql out" %]

- `distinct` keyword must appear right after `select`
  - SQL was supposed to read like English
- Shows distinct combinations
- Blanks in `sex` column show missing data
  - We'll talk about this in a bit

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

[% double stem="filter" suffix="sql out" %]

- <code>where <em>condition</em></code> <a href="#g:filter">filters</a> the rows produced by selection
- Condition is evaluated independently for each row
- Only rows that pass the test appear in results
- Use single quotes for `'text data'` and double quotes for `"weird column names"`
  - SQLite will accept double-quoted text data but [SQLFluff][sqlfluff] will complain

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a query to select the body masses from `penguins` that are less than 3000.0 grams.

[% exercise %]
Write another query to select the species and sex of penguins that weight less than 3000.0 grams.
This shows that the columns displayed and those used in filtering are independent of each other.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Filtering with More Complex Conditions" %]

[% double stem="filter_and" suffix="sql out" %]

- `and`: both sub-conditions must be true
- `or`: either or both part must be true
- Notice that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test
  - We'll talk about this in a bit

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Use the `not` operator to select penguins that are _not_ Gentoos.

[% exercise %]
SQL's `or` is an <a href="#g:inclusive_or">inclusive or</a>:
it succeeds if either _or both_ conditions are true.
SQL does not provide a specific operator for <a href="#g:exclusive_or">exclusive or</a>,
which is true if either _but not both_ conditions are true,
but the same effect can be achieved using `and`, `or`, and `not`.
Write a query to select penguins that are female _or_ on Torgersen Island _but not both_.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Doing Calculations" %]

[% double stem="calculations" suffix="sql out" %]

- Can do the usual kinds of arithmetic on individual values
  - Calculation done for each row independently
- Column name shows the calculation done

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Renaming Columns" %]

[% double stem="rename_columns" suffix="sql out" %]

- Use <code><em>expression</em> as <em>name</em></code> to rename
- Give result of calculation a meaningful name
- Can also rename columns without modifying

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

[% double stem="show_missing_values" suffix="sql out" %]

- SQL uses a special value <a href="#g:null"><code>null</code></a> to representing missing data
  - Not 0 or empty string, but "I don't know"
- Flipper length and body weight not known for one of the first five penguins
- "I don't know" divided by 10 or 1000 is "I don't know"

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

- Repeated from earlier (so it doesn't count against our query limit)

[% double stem="filter" suffix="sql out" %]

- If we ask for female penguins the row with the missing sex drops out

[% double stem="null_equality" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Null Inequality" %]

- But if we ask for penguins that _aren't_ female it drops out as well

[% double stem="null_inequality" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Ternary Logic" %]

[% double stem="ternary_logic" suffix="sql out" %]

- If we don't know the left and right values, we don't know if they're equal or not
- So the result is `null`
- Get the same answer for `null != null`
- <a href="#g:ternary_logic">Ternary logic</a>

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

[% double stem="safe_null_equality" suffix="sql out" %]

- Use `is null` and `is not null` to handle null safely
- Other parts of SQL handle nulls specially

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

[% double stem="simple_sum" suffix="sql out" %]

- <a href="#g:aggregation">Aggregation</a> combines many values to produce one
- `sum` is an <a href="#g:aggregation_func">aggregation function</a>
- Combines corresponding values from multiple rows

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Common Aggregation Functions" %]

[% double stem="common_aggregations" suffix="sql out" %]

- This actually shouldn't work:
  can't calculate maximum or average if any values are null
- SQL does the useful thing instead of the right one

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
What is the average body mass of penguins that weight more than 3000.0 grams?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Counting" %]

[% double stem="count_behavior" suffix="sql out" %]

- `count(*)` counts rows
- <code>count(<em>column</em>)</code> counts non-null entries in column
- <code>count(distinct <em>column</em>)</code> counts distinct non-null entries

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
How many different body masses are in the penguins dataset?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Grouping" %]

[% double stem="simple_group" suffix="sql out" %]

- Put rows in <a href="#g:group">groups</a> based on distinct combinations of values in columns specified with `group by`
- Then perform aggregation separately for each group
- But which is which?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Behavior of Unaggregated Columns" %]

[% double stem="unaggregated_columns" suffix="sql out" %]

- All rows in each group have the same value for `sex`, so no need to aggregate

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Arbitrary Choice in Aggregation" %]

[% double stem="arbitrary_in_aggregation" suffix="sql out" %]

- If we don't specify how to aggregate a column,
  SQLite chooses _any arbitrary value_ from the group
  - All penguins in each group have the same sex because we grouped by that, so we get the right answer
  - The body mass values are in the data but unpredictable
  - A common mistake
- Other database managers don't do this
  - E.g., PostgreSQL complains that column must be used in an aggregation function

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

[% double stem="filter_aggregation" suffix="sql out" %]

- Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Readable Output" %]

[% double stem="readable_aggregation" suffix="sql out" %]

- Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Filtering Aggregate Inputs" %]

[% double stem="filter_aggregate_inputs" suffix="sql out" %]

- <code>filter (where <em>condition</em>)</code> applies to _inputs_

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

- "Connect" to an <a href="#g:in_memory_db">in-memory database</a>
  - Changes aren't saved to disk
  - Very useful for testing (discussed later)

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Creating Tables" %]

[% single "src/create_work_job.sql" %]

- <code>create table <em>name</em></code> followed by parenthesized list of columns
- Each column is a name, a data type, and optional extra information
  - E.g., `not null` prevents nulls from being added
- `.schema` is _not_ standard SQL
- SQLite has added a few things
  - `create if not exists`
  - upper-case keywords (SQL is case insensitive)

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Inserting Data" %]

[% single "src/populate_work_job.sql" %]
[% single "out/insert_values.out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Following Along" %]

- To re-create this database:
  - [Download the examples]([% config "release" %])
  - Unzip that file
  - `.read src/create_work_job.sql`
  - `.read src/populate_work_job.sql`

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

[% single "src/update_work_job.sql" %]
[% single "out/update_rows.out" %]

- (Almost) always specify row(s) to update using `where`
  - Otherwise update all rows in table, which is usually not wanted

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Deleting Rows" %]

[% double stem="delete_rows" suffix="sql out" %]

- Again, (almost) always specify row(s) to delete using `where`

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
What happens if you try to delete rows that don't exist
(e.g., all entries in `work` that refer to `juna`)?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Backing Up" %]

[% double stem="backing_up" suffix="sql out" %]

- We will explore another strategy based on <a href="#g:tombstone">tombstones</a> below

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

[% double stem="cross_join" suffix="sql out" %]

- A <a href="#g:join">join</a> combines information from two tables
- <a href="#g:cross_join">cross join</a> constructs their cross product
  - All combinations of rows from each
- Result isn't particularly useful: `job` and `name` values don't match
  - I.e., the combined data has records whose parts have nothing to do with each other

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Inner Join" %]

[% double stem="inner_join" suffix="sql out" %]

- Use <code><em>table</em>.<em>column</em></code> notation to specify columns
  - A column can have the same name as a table
- Use <code>on <em>condition</em></code> to specify <a href="#g:join_condition">join condition</a>
- Since `complain` doesn't appear in `job.name`, none of those rows are kept

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Re-run the query shown above using `where job = name` instead of the full `table.name` notation.
Is the shortened form easier or harder to read
and more or less likely to cause errors?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Aggregating Joined Data" %]

[% double stem="aggregate_join" suffix="sql out" %]

- Combines ideas we've seen before
- But Tay is missing from the table
  - No records in the `job` table with `tay` as name
  - So no records to be grouped and summed

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Left Join" %]

[% double stem="left_join" suffix="sql out" %]

- A <a href="#g:left_outer_join">left outer join</a> keeps all rows from the left table
- Fills missing values from right table with null

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Aggregating Left Joins" %]

[% double stem="aggregate_left_join" suffix="sql out" %]

- That's better, but we'd like to see 0 rather than a blank

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Coalescing Values" %]

[% double stem="coalesce" suffix="sql out" %]

- <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Full Outer Join" %]

- <a href="#g:full_outer_join">Full outer join</a> is the union of
  left outer join and <a href="#g:right_outer_join">right outer join</a>
- Almost the same as cross join, but consider:

[% double stem="full_outer_join" suffix="sql out" %]

- A cross join would produce empty result

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

- Who doesn't calibrate?

[% double stem="negate_incorrectly" suffix="sql out" %]

- But Mik _does_ calibrate
- Problem is that there's an entry for Mik cleaning
- And since `'clean' != 'calibrate'`, that row is included in the results
- We need a different approach…

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Set Membership" %]

[% double stem="set_membership" suffix="sql out" %]

- <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Subqueries" %]

[% double stem="subquery_set" suffix="sql out" %]

- Use a <a href="#g:subquery">subquery</a> to select the people who _do_ calibrate
- Then select all the people who _aren't_ in that set
- Initially feels odd, but subqueries are useful in other ways

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Defining a Primary Key" %]

- Can use any field (or combination of fields) in a table as a <a href="#g:primary_key">primary key</a>
  as long as value(s) unique for each record
- Uniquely identifies a particular record in a particular table

[% double stem="primary_key" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Does the `penguins` table have a primary key?
If so, what is it?
What about the `work` and `job` tables?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Autoincrementing and Primary Keys" %]

[% double stem="autoincrement" suffix="sql out" %]

- Database <a href="#g:autoincrement">autoincrements</a> `ident` each time a new record is added
- Common to use that field as the primary key
  - Unique for each record
- If Mik changes their name again,
  we only have to change one fact in the database
- Downside: manual queries are harder to read (who is person 17?)

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Internal Tables" %]

[% double stem="sequence_table" suffix="sql out" %]

- Sequence numbers are _not_ reset when rows are deleted
  - In part so that they can be used as primary keys

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Are you able to modify the values stored in `sqlite_sequence`?
In particular,
are you able to reset the values so that
the same sequence numbers are generated again?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Altering Tables" %]

[% double stem="alter_tables" suffix="sql out" %]

- Add a column after the fact
- Since it can't be null, we have to provide a default value
  - Really want to make it the primary key, but SQLite doesn't allow that after the fact
- Then use `update` to modify existing records
  - Can modify any number of records at once
  - So be careful about `where` clause
- An example of <a href="#g:data_migration">data migration</a>

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="M-to-N Relationships" %]

- Relationships between entities are usually characterized as:
  - <a href="#g:1_to_1">1-to-1</a>:
    fields in the same record
  - <a href="#g:1_to_many">1-to-many</a>:
    the many have a <a href="#g:foreign_key">foreign key</a> referring to the one's primary key
  - <a href="#g:many_to_many">many-to-many</a>:
    don't know how many keys to add to records ("maximum" never is)
- Nearly-universal solution is a <a href="#g:join_table">join table</a>
  - Each record is a pair of foreign keys
  - I.e., each record is the fact that records A and B are related

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Creating New Tables from Old" %]

[% double stem="insert_select" suffix="sql out" %]

- `new_work` is our join table
- Each column refers to a record in some other table

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Removing Tables" %]

[% double stem="drop_table" suffix="sql out" %]

- Remove the old table and rename the new one to take its place
  - Note `if exists`
- Please back up your data first

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

- Go back to the original penguins database

[% double stem="compare_individual_aggregate" suffix="sql out" %]

- Get average body mass in subquery
- Compare each row against that
- Requires two scans of the data, but no way to avoid that
  - Except calculating a running total each time a penguin is added to the table
- Null values aren't included in the average or in the final results

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Use a subquery to find the number of penguins
that weigh the same as the lightest penguin.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Comparing Individual Values to Aggregates Within Groups" %]

[% double stem="compare_within_groups" suffix="sql out" %]

- Subquery runs first to create temporary table `averaged` with average mass per species
- Join that with `penguins`
- Filter to find penguins heavier than average within their species

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Use a subquery to find the number of penguins
that weigh the same as the lightest penguin of the same sex and species.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Common Table Expressions" %]

[% double stem="common_table_expressions" suffix="sql out" %]

- Use <a href="#g:cte">common table expression</a> (CTE) to make queries clearer
  - Nested subqueries quickly become difficult to understand
- Database decides how to optimize

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Explaining Query Plans" %]

[% double stem="explain_query_plan" suffix="sql out" %]

- SQLite plans to scan every row of the table
- It will build a temporary <a href="#g:b_tree">B-tree data structure</a> to group rows

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Use a CTE to find
the number of penguins
that weigh the same as the lightest penguin of the same sex and species.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Enumerating Rows" %]

- Every table has a special column called `rowid`

[% double stem="rowid" suffix="sql out" %]

- `rowid` is persistent within a session
  - I.e., if we delete the first 5 rows we now have row IDs 6…N
- _Do not rely on row ID_
  - In particular, do not use it as a key

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

[% double stem="if_else" suffix="sql out" %]

- <code>iif(<em>condition</em>, <em>true_result</em>, <em>false_result</em>)</code>
  - Note: `iif` with two i's
- May feel odd to think of `if`/`else` as a function,
  but common in <a href="#g:vectorization">vectorized</a> calculations

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
What does each of the expressions shown below produce?
Which ones do you think actually attempt to divide by zero?

1.  `iif(0, 123, 1/0)`
1.  `iif(1, 123, 1/0)`
1.  `iif(0, 1/0, 123)`
1.  `iif(1, 1/0, 123)`

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Selecting a Case" %]

- What if we want small, medium, and large?
- Can nest `iif`, but quickly becomes unreadable

[% double stem="case_when" suffix="sql out" %]

- Evaluate `when` options in order and take first
- Result of `case` is null if no condition is true
- Use `else` as fallback

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Modify the query above so that
the outputs are `"penguin is small"` and `"penguin is large"`
by concatenating the string `"penguin is "` to the entire `case`
rather than to the individual `when` branches.
(This exercise shows that `case`/`when` is an <a href="#g:expression">expression</a>
rather than a <a href="#g:statement">statement</a>.)

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Checking a Range" %]

[% double stem="check_range" suffix="sql out" %]

- `between` can make queries easier to read
- But be careful of the `and` in the middle

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
The expression `val between 'A' and 'Z'` is true if `val` is `'M'` (upper case)
but false if `val` is `'m'` (lower case).
Rewrite the expression using [SQLite's built-in scalar functions][sqlite_function]
so that it is true in both cases.

| name      | purpose                                                                 |
| --------- | ----------------------------------------------------------------------- |
| `substr`  | Get substring given starting point and length                           |
| `trim`    | Remove characters from beginning and end of string                      |
| `ltrim`   | Remove characters from beginning of string                              |
| `rtrim`   | Remove characters from end of string                                    |
| `length`  | Length of string                                                        |
| `replace` | Replace occurrences of substring with another string                    |
| `upper`   | Return upper-case version of string                                     |
| `lower`   | Return lower-case version of string                                     |
| `instr`   | Find location of first occurrence of substring (returns 0 if not found) |

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Yet Another Database" %]

- <a href="#g:er_diagram">Entity-relationship diagram</a> (ER diagram) shows relationships between tables
- Like everything to do with databases, there are lots of variations

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

[% double stem="assay_staff" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Draw a table diagram and an ER diagram to represent the following database:

- `person` has `id` and `full_name`
- `course` has `id` and `name`
- `section` has `course_id`, `start_date`, and `end_date`
- `instructor` has `person_id` and `section_id`
- `student` has `person_id`, `section_id`, and `status`

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Pattern Matching" %]

[% double stem="like_glob" suffix="sql out" %]

- `like` is the original SQL pattern matcher
  - `%` matches zero or more characters at the start or end of a string
  - Case insensitive by default
- `glob` supports Unix-style wildcards

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Rewrite the pattern-matching query shown above using `glob`.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Selecting First and Last Rows" %]

[% double stem="union_all" suffix="sql out" %]

- `union all` combines records
  - Keeps duplicates: `union` on its own only keeps unique records
  - Which is more work but sometimes more useful
- Yes, it feels like the extra `select * from` should be unnecessary

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a query whose result includes two rows for each Adelie penguin
in the `penguins` database.
How can you check that your query is working correctly?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Intersection" %]

[% double stem="intersect" suffix="sql out" %]

- Rows involved must have the same structure
- Intersection usually used when pulling values from different sources
  - In the query above, would be clearer to use `where`

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

[% double stem="except" suffix="sql out" %]

- Again, tables must have same structure
  - And this would be clearer with `where`
- SQL operates on sets, not tables, except where it doesn't

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Use `exclude` to find all Gentoo penguins that _aren't_ male.
How can you check that your query is working correctly?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Random Numbers and Why Not" %]

[% double stem="random_numbers" suffix="sql out" %]

- There is no way to seed SQLite's random number generator
- Which means there is no way to reproduce its pseudo-random sequences
- Which means you should _never_ use it
  - How are you going to debug something you can't re-run?

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a query that:

- uses a CTE to create 1000 random numbers between 0 and 10 inclusive;

- uses a second CTE to calculate their mean; and

- uses a third CTE and [SQLite's built-in math functions][sqlite_math]
  to calculate their standard deviation.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Creating an Index" %]

[% double stem="create_use_index" suffix="sql out" %]

- An <a href="#g:index">index</a> is an auxiliary data structure that enables faster access to records
  - Spend storage space to buy speed
- Don't have to mention it explicitly in queries
  - Database manager will use it automatically
- Unlike primary keys, SQLite supports defining indexes after the fact

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Generating Sequences" %]

[% double stem="generate_sequence" suffix="sql out" %]

- A (non-standard) <a href="#g:table_valued_func">table-valued function</a>

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Generating Sequences Based on Data" %]

[% double stem="data_range_sequence" suffix="sql out" %]

- Must have the parentheses around the `min` and `max` selections to keep SQLite happy

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Generating Sequences of Dates" %]

[% double stem="date_sequence" suffix="sql out" %]

- SQLite represents dates as YYYY-MM-DD strings
  or as Julian days or as Unix milliseconds or…
  - Julian days is fractional number of days since November 24, 4714 BCE
- `julianday` and `date` convert back and forth

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Counting Experiments Started per Day Without Gaps" %]

[% double stem="experiments_per_day" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
What does the expression `date('now', 'start of month', '+1 month', '-1 day')` produce?
(You may find [the documentation on SQLite's date and time functions][sqlite_datetime] helpful.)

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Self Join" %]

[% double stem="self_join" suffix="sql out" %]

- Join a table to itself
  - Use `as` to create <a href="#g:alias">aliases</a> for copies of tables to distinguish them
  - Nothing special about the names `left` and `right`
- Get all <math>n<sup>2</sup></math> pairs, including person with themself

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Generating Unique Pairs" %]

[% double stem="unique_pairs" suffix="sql out" %]

- `left.ident < right.ident` ensures distinct pairs without duplicates
  - Query uses `left.ident <= 4 and right.ident <= 4` to shorten output
- Quick check: <math>n(n-1)/2</math> pairs

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Filtering Pairs" %]

[% double stem="filter_pairs" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Existence and Correlated Subqueries" %]

[% double stem="correlated_subquery" suffix="sql out" %]

- Endocrinology is missing from the list
- `select 1` could equally be `select true` or any other value
- A <a href="#g:correlated_subquery">correlated subquery</a> depends on a value from the outer query
  - Equivalent to nested loop

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Nonexistence" %]

[% double stem="nonexistence" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Can you rewrite the previous query using `exclude`?
If so, is your new query easier to understand?
If the query cannot be rewritten, why not?

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Avoiding Correlated Subqueries" %]

[% double stem="avoid_correlated_subqueries" suffix="sql out" %]

- The join might or might not be faster than the correlated subquery
- Hard to find unstaffed departments without either `not exists` or `count` and a check for 0

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Lead and Lag" %]

[% double stem="lead_lag" suffix="sql out" %]

- Use `strftime` to extract year and month
  - Clumsy, but date/time handling is not SQLite's strong point
- Use <a href="#g:window_func">window functions</a> `lead` and `lag` to shift values
  - Unavailable values at the top or bottom are null

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Boundaries" %]

- [Documentation on SQLite's window functions][sqlite_window] describes
  three frame types and five kinds of frame boundary
- It feels very ad hoc, but so does the real world

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Windowing Functions" %]

[% double stem="window_functions" suffix="sql out" %]

- `sum() over` does a running total
- `cume_dist` is fraction _of rows seen so far_

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Explaining Another Query Plan" %]

[% double stem="explain_window_function" suffix="sql out" %]

- Becomes useful…eventually

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Partitioned Windows" %]

[% double stem="partition_window" suffix="sql out" %]

- `partition by` creates groups
- So this counts experiments started since the beginning of each year

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

[% double stem="blob" suffix="sql out" %]

- A <a href="#g:blob">blob</a> is a binary large object
  - Bytes in, bytes out…
- If you think that's odd, check out [Fossil][fossil]

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
[% double stem="lab_log_schema" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Storing JSON" %]

[% double stem="json_in_table" suffix="sql out" %]

- Store heterogeneous data as <a href="#g:json">JSON</a>-formatted text
  (with double-quoted strings)
  - Database parses the text each time it is queried,
    so performance can be an issue
- Can alternatively store as blob (`jsonb`)
  - Can't view it directly
  - But more efficient

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Select Fields from JSON" %]

[% double stem="json_field" suffix="sql out" %]

- Single arrow `->` returns JSON representation of result
- Double arrow `->>` returns SQL text, integer, real, or null
- Left side is column
- Right side is <a href="#g:path_expression">path expression</a>
  - Start with `$` (meaning "root")
  - Fields separated by `.`

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a query that selects the year from the `"refurbished"` field
of the JSON data associated with the Inphormex plate reader.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="JSON Array Access" %]

[% double stem="json_array" suffix="sql out" %]

- SQLite and other database managers have many [JSON manipulation functions][sqlite_json]
- `json_array_length` gives number of elements in selected array
- Subscripts start with 0
- Characters outside 7-bit ASCII represented as Unicode escapes

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Unpacking JSON Arrays" %]

[% double stem="json_unpack" suffix="sql out" %]

- `json_each` is another table-valued function
- Use <code>json_each.<em>name</em></code> to get properties of unpacked array

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a query that counts how many times each person appears
in the first log entry associated with any piece of equipment.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Selecting the Last Element of an Array" %]

[% double stem="json_array_last" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Modifying JSON" %]

[% double stem="json_modify" suffix="sql out" %]

- Updates the in-memory copy of the JSON, _not_ the database record
- Please use `json_quote` rather than trying to format JSON with string operations

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
As part of cleaning up the lab log database,
replace the machine names in the JSON records in `usage`
with the corresopnding machine IDs from the `machine` table.

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Refreshing the Penguins Database" %]

[% double stem="count_penguins" suffix="sql out" %]

- We will restore full database after each example

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Tombstones" %]

[% single "src/make_active.sql" %]
[% double stem="active_penguins" suffix="sql out" %]

- Use a <a href="#g:tombstone">tombstone</a> to mark (in)active records
- Every query must now include it

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Importing CSV Data" %]

- SQLite and most other database managers have tools for importing and exporting <a href="#g:csv">CSV</a>
- In SQLite:
  - Define table
  - Import data
  - Convert empty strings to nulls (if desired)
  - Convert types from text to whatever (not shown below)

[% single "src/create_penguins.sql" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
What are the data types of the columns in the `penguins` table
created by the CSV import shown above?
How can you correct the ones that need correcting?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Views" %]

[% double stem="views" suffix="sql out" %]

- A <a href="#g:view">view</a> is a saved query that other queries can invoke
- View is re-run each time it's used
- Like a CTE, but:
  - Can be shared between queries
  - Views came first
- Some databases offer <a href="#g:materialized_view">materialized views</a>
  - Update-on-demand temporary tables

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

[% double stem="all_jobs" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Adding Checks" %]

[% double stem="all_jobs_check" suffix="sql out" %]

- `check` adds constraint to table
  - Must produce a Boolean result
  - Run each time values added or modified
- But changes made before the error have taken effect

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Rewrite the definition of the `penguins` table to add the following constraints:

1.  `body_mass_g` must be null or non-negative.

2.  `island` must be one of `"Biscoe"`, `"Dream"`, or `"Torgersen"`.
    (Hint: the `in` operator will be useful here.)

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="ACID" %]

- <a href="#g:atomic">Atomic</a>: change cannot be broken down into smaller ones (i.e., all or nothing)
- <a href="#g:consistent">Consistent</a>: database goes from one consistent state to another
- <a href="#g:isolated">Isolated</a>: looks like changes happened one after another
- <a href="#g:durable">Durable</a>: if change takes place, it's still there after a restart

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Transactions" %]

[% double stem="transaction" suffix="sql out" %]

- Statements outside transaction execute and are committed immediately
- Statement(s) inside transaction don't take effect until:
  - `end transaction` (success)
  - `rollback` (undo)
- Can have any number of statements inside a transaction
- But _cannot_ nest transactions in SQLite
  - Other databases support this

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Rollback in Constraints" %]

[% double stem="rollback_constraint" suffix="sql out" %]

- All of second `insert` rolled back as soon as error occurred
- But first `insert` took effect

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Rollback in Statements" %]

[% double stem="rollback_statement" suffix="sql out" %]

- Constraint is in table definition
- Action is in statement

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Upsert" %]

[% double stem="upsert" suffix="sql out" %]

- <a href="#g:upsert">upsert</a> stands for "update or insert"
  - Create if record doesn't exist
  - Update if it does
- Not standard SQL but widely implemented
- Example also shows use of SQLite `.print` command

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

- First <a href="#g:normal_form">normal form</a> (1NF):
  every field of every record contains one indivisible value.

- Second normal form (2NF) and third normal form (3NF):
  every value in a record that isn't a key depends solely on the key,
  not on other values.

- <a href="#g:denormalization">Denormalization</a>: explicitly store values that could be calculated on the fly
  - To simplify queries and/or make processing faster

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Creating Triggers" %]

[% single "src/trigger_setup.sql" %]

- A <a href="#g:trigger">trigger</a> automatically runs before or after a specified operation
- Can have side effects (e.g., update some other table)
- And/or implement checks (e.g., make sure other records exist)
- Add processing overhead…
- …but data is either cheap or correct, never both
- Inside trigger, refer to old and new versions of record
  as <code>old.<em>column</em></code> and <code>new.<em>column</em></code>

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Trigger Not Firing" %]

[% double stem="trigger_successful" suffix="sql out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Trigger Firing" %]

[% double stem="trigger_firing" suffix="sql out" %]

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
[% double stem="represent_graph" suffix="sql out" %]

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

[% double stem="recursive_lineage" suffix="sql out" %]

- Use a <a href="#g:recursive_cte">recursive CTE</a> to create a temporary table (`descendent`)
- <a href="#g:base_case">Base case</a> seeds this table
- <a href="#g:recursive_case">Recursive case</a> relies on value(s) already in that table and external table(s)
- `union all` to combine rows
  - Can use `union` but that has lower performance (must check uniqueness each time)
- Stops when the recursive case yields an empty row set (nothing new to add)
- Then select the desired values from the CTE

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Modify the recursive query shown above to use `union` instead of `union all`.
Does this affect the result?
Why or why not?

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Contact Tracing Database" %]

[% double stem="contact_person" suffix="sql out" %]
[% double stem="contact_contacts" suffix="sql out" %]

[% figure
file="img/contact_tracing.svg"
title="contact diagram"
alt="box and line diagram showing who has had contact with whom"
%]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Bidirectional Contacts" %]

[% double stem="bidirectional" suffix="sql out" %]

- Create a <a href="#g:temporary_table">temporary table</a> rather than using a long chain of CTEs
  - Only lasts as long as the session (not saved to disk)
- Duplicate information rather than writing more complicated query

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Updating Group Identifiers" %]

[% double stem="update_group_ids" suffix="sql out" %]

- `new_ident` is minimum of own identifier and identifiers one step away
- Doesn't keep people with no contacts

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Recursive Labeling" %]

[% double stem="recursive_labeling" suffix="sql out" %]

- Use `union` instead of `union all` to prevent <a href="#g:infinite_recursion">infinite recursion</a>

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

[% section_break class="topic" title="Querying from Python" %]

[% double stem="basic_python_query" suffix="py out" %]

- `sqlite3` is part of Python's standard library
- Create a connection to a database file
- Get a <a href="#g:cursor">cursor</a> by executing a query
  - More common to create cursor and use that to run queries
- Fetch all rows at once as list of tuples

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Incremental Fetch" %]

[% double stem="incremental_fetch" suffix="py out" %]

- `cursor.fetchone` returns `None` when no more data
- There is also `fetchmany(N)` to fetch (up to) a certain number of rows

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Insert, Delete, and All That" %]

[% double stem="insert_delete" suffix="py out" %]

- Each `execute` is its own transaction

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Interpolating Values" %]

[% double stem="interpolate" suffix="py out" %]

- From [XKCD][xkcd-tables]

[% figure
file="img/xkcd_327_exploits_of_a_mom.png"
title="XKCD Exploits of a Mom"
alt="XKCD cartoon showing a mother scolding a school for not being more careful about SQL injection attacks"
%]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a Python script that takes island, species, sex, and other values as command-line arguments
and inserts an entry into the penguins database.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Script Execution" %]

[% double stem="script_execution" suffix="py out" %]

- But what if something goes wrong?

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="SQLite Exceptions in Python" %]

[% double stem="exceptions" suffix="py out" %]

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Python in SQLite" %]

[% double stem="embedded_python" suffix="py out" %]

- SQLite calls back into Python to execute the function
- Other databases can run Python (and other languages) in the database server process
- Be careful

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Handling Dates and Times" %]

[% double stem="dates_times" suffix="py out" %]

- `sqlite3.PARSE_DECLTYPES` tells `sqlite3` library to use converts based on declared column types
- Adapt on the way in, convert on the way out

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a Python adapter that truncates real values to two decimal places
as they are being written to the database.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="SQL in Jupyter Notebooks" %]

[% single "src/install_jupysql.sh" %]

- And then inside the notebook:

[% single "src/load_ext.text" %]

- Loads extension

[% double stem="jupyter_connect" suffix="text out" %]

- Connects to database
  - `sqlite://` with two slashes is the protocol
  - `/data/penguins.db` (one leading slash) is a local path
- Single percent sign `%sql` introduces one-line command
- Use double percent sign `%%sql` to indicate that the rest of the cell is SQL

[% double stem="jupyter_select" suffix="text out" %]

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

[% section_break class="topic" title="Pandas and SQL" %]

[% single "src/install_pandas.sh" %]
[% double stem="select_pandas" suffix="py out" %]

- Be careful about datatype conversion when using [Pandas][pandas]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a command-line Python script that uses Pandas to re-create the penguins database.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Polars and SQL" %]

[% single "src/install_polars.sh" %]
[% double stem="select_polars" suffix="py out" %]

- The <a href="#g:uri">Uniform Resource Identifier</a> (URI) specifies the database
- The query is the query
- Use the ADBC engine instead of the default ConnectorX with [Polars][polars]

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a command-line Python script that uses Polars to re-create the penguins database.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Object-Relational Mappers" %]

[% double stem="orm" suffix="py out" %]

- An <a href="#g:orm">object-relational mapper</a> (ORM) translates table columns to object properties and vice versa
- [SQLModel][sqlmodel] relies on Python type hints

<!-- ---------------------------------------------------------------- -->

[% section_break class="exercise" %]

[% exercise %]
Write a command-line Python script that uses SQLModel to re-create the penguins database.

<!-- ---------------------------------------------------------------- -->

[% section_break class="topic" title="Relations with ORMs" %]

[% double stem="orm_relation" suffix="py out" %]

- Make foreign keys explicit in class definitions
- SQLModel automatically does the join
  - The two staff with no department aren't included in the result

<!-- ---------------------------------------------------------------- -->

[% section_break class="aside" title="Appendices" %]

### Glossary

[% glossary %]

### Acknowledgments

This tutorial would not have been possible without:

- [Andi Albrecht][albrecht-andi]'s [`sqlparse`][sqlparse] module
- [Dimitri Fontaine][fontaine-dimitri]'s [_The Art of PostgreSQL_][art-postgresql]
- David Rozenshtein's _The Essence of SQL_ (now sadly out of print)

I would also like to thank the following for spotting issues, making suggestions, or submitting changes:

[% thanks %]

### Links

[% link_table %]

[% section_end %]
