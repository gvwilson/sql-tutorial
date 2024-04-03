---
title: "Aggregating"
tagline: "Turning many values into one."
---

## Aggregating

[%inc simple_sum.sql %]
[%inc simple_sum.out %]

-   [%g aggregation "Aggregation" %] combines many values to produce one
-   `sum` is an [%g aggregation_func "aggregation function" %]
-   Combines corresponding values from multiple rows

## Common Aggregation Functions

[%inc common_aggregations.sql %]
[%inc common_aggregations.out %]

-   This actually shouldn't work:
    can't calculate maximum or average if any values are null
-   SQL does the useful thing instead of the right one

## Exercise {: .exercise}

What is the average body mass of penguins that weight more than 3000.0 grams?

## Counting

[%inc count_behavior.sql %]
[%inc count_behavior.out %]

-   `count(*)` counts rows
-   <code>count(<em>column</em>)</code> counts non-null entries in column
-   <code>count(distinct <em>column</em>)</code> counts distinct non-null entries

## Exercise {: .exercise}

How many different body masses are in the penguins dataset?

## Grouping

[%inc simple_group.sql %]
[%inc simple_group.out %]

-   Put rows in [%g group "groups" %] based on distinct combinations of values in columns specified with `group by`
-   Then perform aggregation separately for each group
-   But which is which?

## Behavior of Unaggregated Columns

[%inc unaggregated_columns.sql %]
[%inc unaggregated_columns.out %]

-   All rows in each group have the same value for `sex`, so no need to aggregate

## Arbitrary Choice in Aggregation

[%inc arbitrary_in_aggregation.sql %]
[%inc arbitrary_in_aggregation.out %]

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

[%inc filter_aggregation.sql %]
[%inc filter_aggregation.out %]

-   Using <code>having <em>condition</em></code> instead of <code>where <em>condition</em></code> for aggregates

## Readable Output

[%inc readable_aggregation.sql %]
[%inc readable_aggregation.out %]

-   Use <code>round(<em>value</em>, <em>decimals</em>)</code> to round off a number

## Filtering Aggregate Inputs

[%inc filter_aggregate_inputs.sql %]
[%inc filter_aggregate_inputs.out %]

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
