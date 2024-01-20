# SQL in 100 Queries

## null: connect to database

```bash
sqlite3 data/penguins.db
```

-   Not actually a query
-   But we have to do it before we can do anything else

## 001: select constant

```sql
select 1;
```
```
1
```

-   `select` is a keyword
-   Normally used to select data from table…
-   …but if all we want is a constant value, we don't need to specify one
-   Semi-colon terminator is required

## 002: select all values from table

```sql
select * from little_penguins;
```
```
Adelie|Torgersen|38.5|17.9|190|3325|FEMALE
Adelie|Biscoe|37.7|18.7|180|3600|MALE
Adelie|Torgersen|37.3|20.5|199|3775|MALE
Adelie|Dream|40.7|17|190|3725|MALE
Chinstrap|Dream|51|18.8|203|4100|MALE
Chinstrap|Dream|51.9|19.5|206|3950|MALE
Adelie|Dream|38.8|20|190|3950|MALE
Gentoo|Biscoe|45.2|15.8|215|5300|MALE
Adelie|Torgersen|35.9|16.6|190|3050|FEMALE
Chinstrap|Dream|45.2|16.6|191|3250|FEMALE
```

-   Use `*` to mean "all columns"
-   Use <code>from <em>tablename</em></code> to specify table
-   Output format is not particularly readable

## null: administration commands

```sql
.headers on
.mode markdown
select * from little_penguins;
```
```
|  species  |  island   | bill_length_mm | bill_depth_mm | flipper_length_mm | body_mass_g |  sex   |
|-----------|-----------|----------------|---------------|-------------------|-------------|--------|
| Adelie    | Torgersen | 38.5           | 17.9          | 190               | 3325        | FEMALE |
| Adelie    | Biscoe    | 37.7           | 18.7          | 180               | 3600        | MALE   |
| Adelie    | Torgersen | 37.3           | 20.5          | 199               | 3775        | MALE   |
| Adelie    | Dream     | 40.7           | 17            | 190               | 3725        | MALE   |
| Chinstrap | Dream     | 51             | 18.8          | 203               | 4100        | MALE   |
| Chinstrap | Dream     | 51.9           | 19.5          | 206               | 3950        | MALE   |
| Adelie    | Dream     | 38.8           | 20            | 190               | 3950        | MALE   |
| Gentoo    | Biscoe    | 45.2           | 15.8          | 215               | 5300        | MALE   |
| Adelie    | Torgersen | 35.9           | 16.6          | 190               | 3050        | FEMALE |
| Chinstrap | Dream     | 45.2           | 16.6          | 191               | 3250        | FEMALE |
```

-   SQLite administrative commands start with `.` and *aren't* part of the SQL standard
    -   PostgreSQL's special commands start with `\`
-   Use `.help` for a complete list

## 003: specify columns

```sql
select species, island, sex
from little_penguins;
```
```
|  species  |  sex   |  island   |
|-----------|--------|-----------|
| Adelie    | FEMALE | Torgersen |
| Adelie    | MALE   | Biscoe    |
| Adelie    | MALE   | Torgersen |
| Adelie    | MALE   | Dream     |
| Chinstrap | MALE   | Dream     |
| Chinstrap | MALE   | Dream     |
| Adelie    | MALE   | Dream     |
| Gentoo    | MALE   | Biscoe    |
| Adelie    | FEMALE | Torgersen |
| Chinstrap | FEMALE | Dream     |
```

-   Specify column names separated by commas
    -   In any order
    -   Duplicates allowed
-   Line breaks ~allowed~ encouraged for readability

## 004: sorting

```sql
select species, sex, island
from little_penguins
order by island asc, sex desc;
```
```
|  species  |  sex   |  island   |
|-----------|--------|-----------|
| Adelie    | MALE   | Biscoe    |
| Gentoo    | MALE   | Biscoe    |
| Adelie    | MALE   | Dream     |
| Chinstrap | MALE   | Dream     |
| Chinstrap | MALE   | Dream     |
| Adelie    | MALE   | Dream     |
| Chinstrap | FEMALE | Dream     |
| Adelie    | MALE   | Torgersen |
| Adelie    | FEMALE | Torgersen |
| Adelie    | FEMALE | Torgersen |
```

-   `order by` must follow `from` (which must follow `select`)
-   `asc` is ascending, `desc` is descending
    -   Default is ascending, but please specify

## 005: limiting output

-   Full dataset has 344 rows

```sql
select species, sex, island
from penguins -- full table
limit 5;
```
```
| species |  sex   |  island   |
|---------|--------|-----------|
| Adelie  | MALE   | Torgersen |
| Adelie  | FEMALE | Torgersen |
| Adelie  | FEMALE | Torgersen |
| Adelie  |        | Torgersen |
| Adelie  | FEMALE | Torgersen |
```

-   Comments start with `--` and run to the end of the line
-   <code>limit <em>N</em></code> specifies maximum number of rows returned by query

## 006: paging output

```sql
select species, sex, island
from penguins
limit 5 offset 5;
```
```
| species |  sex   |  island   |
|---------|--------|-----------|
| Adelie  | MALE   | Torgersen |
| Adelie  | FEMALE | Torgersen |
| Adelie  | MALE   | Torgersen |
| Adelie  |        | Torgersen |
| Adelie  |        | Torgersen |
```

-   <code>offset <em>N</em></code> must follow `limit`
-   Specifies number of rows to skip

## 007: removing duplicates

```sql
select distinct species, sex, island
from penguins;
```
```
|  species  |  sex   |  island   |
|-----------|--------|-----------|
| Adelie    | MALE   | Torgersen |
| Adelie    | FEMALE | Torgersen |
| Adelie    |        | Torgersen |
| Adelie    | FEMALE | Biscoe    |
| Adelie    | MALE   | Biscoe    |
| Adelie    | FEMALE | Dream     |
| Adelie    | MALE   | Dream     |
| Adelie    |        | Dream     |
| Chinstrap | FEMALE | Dream     |
| Chinstrap | MALE   | Dream     |
| Gentoo    | FEMALE | Biscoe    |
| Gentoo    | MALE   | Biscoe    |
| Gentoo    |        | Biscoe    |
```

-   `distinct` keyword must appear right after `select`
    -   SQL was supposed to read like English…
-   Shows distinct combinations
-   Blanks in `sex` column show missing data
    -   We'll talk about this in a bit

## 008: filtering results

```sql
select distinct species, sex, island
from penguins
where island = "Biscoe";
```
```
| species |  sex   | island |
|---------|--------|--------|
| Adelie  | FEMALE | Biscoe |
| Adelie  | MALE   | Biscoe |
| Gentoo  | FEMALE | Biscoe |
| Gentoo  | MALE   | Biscoe |
| Gentoo  |        | Biscoe |
```

-   <code>where <em>condition</em></code> filters the rows produced by selection
-   Condition is evaluated independently for each row
-   Only rows that pass the test appear in results

## 009: more complex filter conditions

```sql
select distinct species, sex, island
from penguins
where island = "Biscoe" and sex != "MALE";
```
```
| species |  sex   | island |
|---------|--------|--------|
| Adelie  | FEMALE | Biscoe |
| Gentoo  | FEMALE | Biscoe |
```

-   `and`: both sub-conditions must be true
-   `or`: either or both part must be true
-   Notice that the row for Gentoo penguins on Biscoe island with unknown (empty) sex didn't pass the test
    -   We'll talk about this in a bit

## 010: doing calculations

```sql
select
    flipper_length_mm / 10.0,
    body_mass_g / 1000.0
from penguins
limit 3;
```
```
| flipper_length_mm / 10.0 | body_mass_g / 1000.0 |
|--------------------------|----------------------|
| 18.1                     | 3.75                 |
| 18.6                     | 3.8                  |
| 19.5                     | 3.25                 |
```

-   Can do the usual kinds of arithmetic on individual values
    -   Calculation done for each row independently
-   Column name shows the calculation done

## 011: renaming columns

```sql
select
    flipper_length_mm / 10.0 as flipper_cm,
    body_mass_g / 1000.0 as weight_kg,
    island as where_found
from penguins
limit 3;
```
```
| flipper_cm | weight_kg | where_found |
|------------|-----------|-------------|
| 18.1       | 3.75      | Torgersen   |
| 18.6       | 3.8       | Torgersen   |
| 19.5       | 3.25      | Torgersen   |
```

-   Use <code><em>expression</em> as <em>name</em></code> to rename
-   Give result of calculation a meaningful name
-   Can also rename columns without modifying

## 012: calculations with missing values

```sql
select
    flipper_length_mm / 10.0 as flipper_cm,
    body_mass_g / 1000.0 as weight_kg,
    island as where_found
from penguins
limit 5;
```
```
| flipper_cm | weight_kg | where_found |
|------------|-----------|-------------|
| 18.1       | 3.75      | Torgersen   |
| 18.6       | 3.8       | Torgersen   |
| 19.5       | 3.25      | Torgersen   |
|            |           | Torgersen   |
| 19.3       | 3.45      | Torgersen   |
```

-   SQL uses a special value `null` to representing missing data
    -   Not 0 or empty string, but "I don't know"
-   Flipper length and body weight not known for one of the first five penguins
-   "I don't know" divided by 10 or 1000 is "I don't know"

## 013: null isn't equal to anything

```sql
-- repeated from earlier so it doesn't count against our query limit
select distinct species, sex, island
from penguins
where island = "Biscoe";
```
```
| species |  sex   | island |
|---------|--------|--------|
| Adelie  | FEMALE | Biscoe |
| Adelie  | MALE   | Biscoe |
| Gentoo  | FEMALE | Biscoe |
| Gentoo  | MALE   | Biscoe |
| Gentoo  |        | Biscoe |
```

-   If we ask for female penguins the row with the missing sex drops out

```sql
select distinct species, sex, island
from penguins
where island = "Biscoe" and sex == "FEMALE";
```
```
| species |  sex   | island |
|---------|--------|--------|
| Adelie  | FEMALE | Biscoe |
| Gentoo  | FEMALE | Biscoe |
```

## 014: null isn't not equal to anything either

-   But if we ask for penguins that *aren't* female it drops out as well

```sql
select distinct species, sex, island
from penguins
where island = "Biscoe" and sex != "FEMALE";
```
```
| species | sex  | island |
|---------|------|--------|
| Adelie  | MALE | Biscoe |
| Gentoo  | MALE | Biscoe |
```

## 015: null is not equal to null

```sql
select null = null;
```
```
| null = null |
|-------------|
|             |
```

-   If we don't know the left and right values, we don't know if they're equal or not
-   So the result is `null`
-   Get the same answer for `null != null`

-   *three-valued logic*

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

## 016: safely handling null

```sql
select species, sex, island
from penguins
where sex is null;
```
```
| species | sex |  island   |
|---------|-----|-----------|
| Adelie  |     | Torgersen |
| Adelie  |     | Torgersen |
| Adelie  |     | Torgersen |
| Adelie  |     | Torgersen |
| Adelie  |     | Torgersen |
| Adelie  |     | Dream     |
| Gentoo  |     | Biscoe    |
| Gentoo  |     | Biscoe    |
| Gentoo  |     | Biscoe    |
| Gentoo  |     | Biscoe    |
| Gentoo  |     | Biscoe    |
```

-   Use `is null` and `is not null` to handle null safely
-   Other parts of SQL handle nulls specially

## 017: aggregation

```sql
select sum(body_mass_g) as total_mass
from penguins;
```
```
| total_mass |
|------------|
| 1437000    |
```

-   `sum` is an *aggregation function*
-   Combines corresponding values from multiple rows

## 018: common aggregation functions

```sql
select
    max(bill_length_mm) as longest_bill,
    min(flipper_length_mm) as shortest_flipper,
    avg(bill_length_mm) / avg(bill_depth_mm) as weird_ratio
from penguins;
```
```
| longest_bill | shortest_flipper |   weird_ratio    |
|--------------|------------------|------------------|
| 59.6         | 172              | 2.56087082530644 |
```

-   This actually shouldn't work: can't calculate maximum or average if any values are null
-   SQL does the useful thing instead of the right one

## 019: grouping

```sql
select
    avg(body_mass_g) as average_mass_g
from penguins
group by sex;
```
```
|  average_mass_g  |
|------------------|
| 4005.55555555556 |
| 3862.27272727273 |
| 4545.68452380952 |
```

-   Put rows in buckets based on distinct combinations of values in columns specified with `group by`
-   Then perform aggregation separately for each bucket
-   But, uh, which is which?

## 020: ungrouped columns

```sql
select
    sex,
    avg(body_mass_g) as average_mass_g
from penguins
group by sex;
```
```
|  sex   |  average_mass_g  |
|--------|------------------|
|        | 4005.55555555556 |
| FEMALE | 3862.27272727273 |
| MALE   | 4545.68452380952 |
```

-   All rows in each group have the same value for `sex`, so no need to aggregate

## 021: arbitrary choice in aggregation

```sql
select
    sex,
    body_mass_g                   
from penguins
group by sex;
```
```
|  sex   | body_mass_g |
|--------|-------------|
|        |             |
| FEMALE | 3800        |
| MALE   | 3750        |
```

-   If we don't specify how to aggregate a column, SQL can choose *any arbitrary value* from the group
-   All penguins in each group have the same sex because we grouped by that, so we get the right answer
-   The body mass values are in the data but unpredictable
-   A common mistake

## 022: filtering on aggregated values

```sql
select
    sex,
    avg(body_mass_g) as average_mass_g
from penguins
group by sex
having average_mass_g > 4000.0;
```
```
| sex  |  average_mass_g  |
|------|------------------|
|      | 4005.55555555556 |
| MALE | 4545.68452380952 |
```

-   Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

## 023: more readable output

```sql
select
    sex,
    round(avg(body_mass_g), 1) as average_mass_g
from penguins
group by sex
having average_mass_g > 4000.0;
```
```
| sex  | average_mass_g |
|------|----------------|
|      | 4005.6         |
| MALE | 4545.7         |
```

-   Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

## null: temporary database

```bash
$ sqlite3 :memory:
```

-   "Connect" to an *in-memory* database

## 024: creating tables

```sql
create table work(
    person text not null,
    job text not null
);
create table job(
    name text not null,
    billable real not null
);
```

-   <code>create table <em>name</em></code> followed by parenthesized list of columns
-   Each column is a name, a data type, and optional extra information
    -   E.g., `not null` prevents nulls from being added

## 025: inserting data

```sql
insert into job values
    ("calibrate", 1.5),
    ("clean", 0.5)
;
insert into work values
    ("mik", "calibrate"),
    ("mik", "clean"),
    ("mik", "complain"),
    ("po", "clean"),
    ("po", "complain"),
    ("tay", "complain")
;
```

-   Resulting tables

|   name    | billable |
|-----------|----------|
| calibrate | 1.5      |
| clean     | 0.5      |

| person |    job    |
|--------|-----------|
| mik    | calibrate |
| mik    | clean     |
| mik    | complain  |
| po     | clean     |
| po     | complain  |
| tay    | complain  |

## 026: joining tables

```sql
select *
from work cross join job;
```
```
| person |    job    |   name    | billable |
|--------|-----------|-----------|----------|
| mik    | calibrate | calibrate | 1.5      |
| mik    | calibrate | clean     | 0.5      |
| mik    | clean     | calibrate | 1.5      |
| mik    | clean     | clean     | 0.5      |
| mik    | complain  | calibrate | 1.5      |
| mik    | complain  | clean     | 0.5      |
| po     | clean     | calibrate | 1.5      |
| po     | clean     | clean     | 0.5      |
| po     | complain  | calibrate | 1.5      |
| po     | complain  | clean     | 0.5      |
| tay    | complain  | calibrate | 1.5      |
| tay    | complain  | clean     | 0.5      |
```

-   `cross join` (also called *outer join*) constructs cross product of tables
    -   All combinations of rows from each
-   Result isn't particularly useful: `job` and `name` don't match

## 027: inner join

```sql
select *
from work inner join job on work.job = job.name;
```
```
| person |    job    |   name    | billable |
|--------|-----------|-----------|----------|
| mik    | calibrate | calibrate | 1.5      |
| mik    | clean     | clean     | 0.5      |
| po     | clean     | clean     | 0.5      |
```

-   Use <code><em>table</em>.<em>column</em></code> notation to specify columns
    -   A column can have the same name as a table
-   Use <code>on <em>condition</em></code> to specify *join condition*
-   Since `complain` doesn't appear in `job.name`, none of those rows are kept

## 028: aggregating joins

```sql
select
    work.person,
    sum(job.billable) as pay
from work inner join job on work.job = job.name
group by work.person;
```
```
| person | pay |
|--------|-----|
| mik    | 2.0 |
| po     | 0.5 |
```

-   Combines ideas we've seen before
-   But Tay is missing from the table

## 029: left join

```sql
select *
from work left join job on work.job = job.name;
```
```
| person |    job    |   name    | billable |
|--------|-----------|-----------|----------|
| mik    | calibrate | calibrate | 1.5      |
| mik    | clean     | clean     | 0.5      |
| mik    | complain  |           |          |
| po     | clean     | clean     | 0.5      |
| po     | complain  |           |          |
| tay    | complain  |           |          |
```

-   A *left outer join* keeps all rows from the left table
-   Fills missing values from right table with null

## 030: aggregating left joins

```sql
select
    work.person,
    sum(job.billable) as pay
from work left join job on work.job = job.name
group by work.person;
```
```
| person | pay |
|--------|-----|
| mik    | 2.0 |
| po     | 0.5 |
| tay    |     |
```

-   That's better, but we'd like to see 0 rather than a blank

## 031: coalescing values

```sql
select
    work.person,
    coalesce(sum(job.billable), 0.0) as pay
from work left join job on work.job = job.name
group by work.person;
```
```
| person | pay |
|--------|-----|
| mik    | 2.0 |
| po     | 0.5 |
| tay    | 0.0 |
```

-   <code>coalesce(<em>val1</em>, <em>val2</em>, …)</code> returns first non-null value

## 032: incorrect negation

-   Who doesn't calibrate?

```sql
select distinct person
from work
where job != "calibrate";
```
```
| person |
|--------|
| mik    |
| po     |
| tay    |
```

-   But Mik *does* calibrate
-   Problem is that there's an entry for Mik cleaning
-   And since `"clean" != "calibrate"`, that row is included in the results
-   We need a different approach

## 033: set membership

```sql
select *
from work
where person not in ("mik", "tay");
```
```
| person |   job    |
|--------|----------|
| po     | clean    |
| po     | complain |
```

-   <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

## 034: subqueries

```sql
select distinct person
from work
where person not in (
    select distinct person
    from work
    where job = "calibrate"
);
```
```
| person |
|--------|
| po     |
| tay    |
```

-   Use a *subquery* to select the people who *do* calibrate
-   Then select all the people who aren't in that set
-   Initially feels odd, but subqueries are useful in other ways

## 035: comparing individual values to aggregates

-   Go back to penguins for a moment

```sql
select body_mass_g
from penguins
where body_mass_g > (
   select avg(body_mass_g)
   from penguins
)
limit 5;
```
```
| body_mass_g |
|-------------|
| 4675        |
| 4250        |
| 4400        |
| 4500        |
| 4650        |
```

-   Get average body mass in subquery
-   Compare each row against that
-   Requires two scans of the data, but there's no way to avoid that
-   Null values aren't included in the average or in the final results
