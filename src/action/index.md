---
title: "Constraints and Triggers"
tagline: "Setting up useful side effects."
---

## Hours Reminder {: .aside}

[%inc all_jobs.sql %]
[%inc all_jobs.out %]

## Adding Checks

[%inc all_jobs_check.sql %]
[%inc all_jobs_check.out %]

-   `check` adds constraint to table
    -   Must produce a Boolean result
    -   Run each time values added or modified
-   But changes made before the error have taken effect

## Exercise {: .exercise}

Rewrite the definition of the `penguins` table to add the following constraints:

1.  `body_mass_g` must be null or non-negative.

2.  `island` must be one of `"Biscoe"`, `"Dream"`, or `"Torgersen"`.
    (Hint: the `in` operator will be useful here.)

## ACID {: .aside}

-   [%g atomic "Atomic" %]: change cannot be broken down into smaller ones (i.e., all or nothing)
-   [%g consistent "Consistent" %]: database goes from one consistent state to another
-   [%g isolated "Isolated" %]: looks like changes happened one after another
-   [%g durable "Durable" %]: if change takes place, it's still there after a restart

## Transactions

[%inc transaction.sql %]
[%inc transaction.out %]

-   Statements outside transaction execute and are committed immediately
-   Statement(s) inside transaction don't take effect until:
    -   `end transaction` (success)
    -   `rollback` (undo)
-   Can have any number of statements inside a transaction
-   But *cannot* nest transactions in SQLite
    -   Other databases support this

## Rollback in Constraints

[%inc rollback_constraint.sql %]
[%inc rollback_constraint.out %]

-   All of second `insert` rolled back as soon as error occurred
-   But first `insert` took effect

## Rollback in Statements

[%inc rollback_statement.sql %]
[%inc rollback_statement.out %]

-   Constraint is in table definition
-   Action is in statement

## Upsert

[%inc upsert.sql %]
[%inc upsert.out %]

-   [%g upsert "upsert" %] stands for "update or insert"
    -   Create if record doesn't exist
    -   Update if it does
-   Not standard SQL but widely implemented
-   Example also shows use of SQLite `.print` command

## Exercise {: .exercise}

Using the assay database,
write a query that adds or modifies people in the `staff` table as shown:

| personal | family | dept | age |
| -------- | ------ | ---- | --- |
| Pranay   | Khanna | mb   | 41  |
| Riaan    | Dua    | gen  | 23  |
| Parth    | Johel  | gen  | 27  |

## Normalization {: .aside}

-   First [%g normal_form "normal form" %] (1NF):
    every field of every record contains one indivisible value.

-   Second normal form (2NF) and third normal form (3NF):
    every value in a record that isn't a key depends solely on the key,
    not on other values.

-   [%g denormalization "Denormalization" %]: explicitly store values that could be calculated on the fly
    -   To simplify queries and/or make processing faster

## Creating Triggers

[%inc trigger_setup.sql %]

-   A [%g trigger "trigger" %] automatically runs before or after a specified operation
-   Can have side effects (e.g., update some other table)
-   And/or implement checks (e.g., make sure other records exist)
-   Add processing overhead…
-   …but data is either cheap or correct, never both
-   Inside trigger, refer to old and new versions of record
    as <code>old.<em>column</em></code> and <code>new.<em>column</em></code>

## Trigger Not Firing

[%inc trigger_successful.sql mark=keep %]
[%inc trigger_successful.out %]

## Trigger Firing

[%inc trigger_firing.sql mark=keep %]
[%inc trigger_firing.out %]

## Exercise {: .exercise}

Using the penguins database:

1.  create a table called `species` with columns `name` and `count`; and

2.  define a trigger that increments the count associated with each species
    each time a new penguin is added to the `penguins` table.

Does your solution behave correctly when several penguins are added
by a single `insert` statement?
