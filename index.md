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

## 013 and 014: filtering with missing values

```sql
-- repeated from earlier
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

-   `is null` and `is not null` are the safe ways to handle nulls
