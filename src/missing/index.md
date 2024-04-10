---
title: "Missing Values"
tagline: "Handling data that isn't there."
---

## Calculating with Missing Values

[%inc show_missing_values.sql %]
[%inc show_missing_values.out %]

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

[%inc filter.sql %]
[%inc filter.out %]

-   If we ask for female penguins the row with the missing sex drops out

[%inc null_equality.sql %]
[%inc null_equality.out %]

## Null Inequality

-   But if we ask for penguins that *aren't* female it drops out as well

[%inc null_inequality.sql %]
[%inc null_inequality.out %]

## Ternary Logic

[%inc ternary_logic.sql %]
[%inc ternary_logic.out %]

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

## Handling Null Safely

[%inc safe_null_equality.sql %]
[%inc safe_null_equality.out %]

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
