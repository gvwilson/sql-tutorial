---
title: "Recursive Queries"
tagline: "Representing and querying graphs."
---

## Representing Graphs {: .aside}

[%inc lineage_setup.sql %]
[%inc represent_graph.sql mark=keep %]
[%inc represent_graph.out %]

[% figure
   slug="recursive_lineage"
   img="recursive_lineage.svg"
   caption="lineage diagram"
   alt="box and arrow diagram showing who is descended from whom in the lineage database"
%]

## Exercise {: .exercise}

Write a query that uses a self join to find every person's grandchildren.

## Recursive Queries

[%inc recursive_lineage.sql mark=keep %]
[%inc recursive_lineage.out %]

-   Use a [%g recursive_cte "recursive CTE" %] to create a temporary table (`descendent`)
-   [%g base_case "Base case" %] seeds this table
-   [%g recursive_case "Recursive case" %] relies on value(s) already in that table and external table(s)
-   `union all` to combine rows
    -   Can use `union` but that has lower performance (must check uniqueness each time)
-   Stops when the recursive case yields an empty row set (nothing new to add)
-   Then select the desired values from the CTE

## Exercise {: .exercise}

Modify the recursive query shown above to use `union` instead of `union all`.
Does this affect the result?
Why or why not?

## Contact Tracing Database {: .aside}

[%inc contact_person.sql %]
[%inc contact_person.out %]
[%inc contact_contacts.sql %]
[%inc contact_contacts.out %]

[% figure
   slug="recursive_contacts"
   img="recursive_contacts.svg"
   caption="contact diagram"
   alt="box and line diagram showing who has had contact with whom"
%]

## Bidirectional Contacts

[%inc bidirectional.sql mark=keep %]
[%inc bidirectional.out %]

-   Create a [%g temporary_table "temporary table" %] rather than using a long chain of CTEs
    -   Only lasts as long as the session (not saved to disk)
-   Duplicate information rather than writing more complicated query

## Updating Group Identifiers

[%inc update_group_ids.sql mark=keep %]
[%inc update_group_ids.out %]

-   `new_ident` is minimum of own identifier and identifiers one step away
-   Doesn't keep people with no contacts

## Recursive Labeling

[%inc recursive_labeling.sql mark=keep %]
[%inc recursive_labeling.out %]

-   Use `union` instead of `union all` to prevent [%g infinite_recursion "infinite recursion" %]

## Exercise {: .exercise}

Modify the query above to use `union all` instead of `union` to trigger infinite recursion.
How can you modify the query so that it stops at a certain depth
so that you can trace its output?

## Check Understanding {: .aside}

[% figure
   slug="recursive_concept_map"
   img="recursive_concept_map.svg"
   caption="common table expressions"
   alt="box and arrow diagram showing concepts related to common table expressions in SQL"
%]
