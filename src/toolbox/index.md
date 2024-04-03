---
title: "SQL Tools"
tagline: "Negation, subqueries, and more."
---

## Negating Incorrectly

-   Who doesn't calibrate?

[%inc negate_incorrectly.sql mark=keep %]
[%inc negate_incorrectly.out %]

-   But Mik *does* calibrate
-   Problem is that there's an entry for Mik cleaning
-   And since `'clean' != 'calibrate'`, that row is included in the results
-   We need a different approach…

## Set Membership

[%inc set_membership.sql mark=keep %]
[%inc set_membership.out %]

-   <code>in <em>values</em></code> and <code>not in <em>values</em></code> do exactly what you expect

## Subqueries

[%inc subquery_set.sql mark=keep %]
[%inc subquery_set.out %]

-   Use a [%g subquery "subquery" %] to select the people who *do* calibrate
-   Then select all the people who *aren't* in that set
-   Initially feels odd, but subqueries are useful in other ways

## Defining a Primary Key {: .aside}

-   Can use any field (or combination of fields) in a table as a [%g primary_key "primary key" %]
    as long as value(s) unique for each record
-   Uniquely identifies a particular record in a particular table

[%inc primary_key.sql %]
[%inc primary_key.out %]

## Exercise {: .exercise}

Does the `penguins` table have a primary key?
If so, what is it?
What about the `work` and `job` tables?

## Autoincrementing and Primary Keys

[%inc autoincrement.sql %]
[%inc autoincrement.out %]

-   Database [%g autoincrement "autoincrements" %] `ident` each time a new record is added
-   Common to use that field as the primary key
    -   Unique for each record
-   If Mik changes their name again,
    we only have to change one fact in the database
-   Downside: manual queries are harder to read (who is person 17?)

## Internal Tables {: .aside}

[%inc sequence_table.sql mark=keep %]
[%inc sequence_table.out %]

-   Sequence numbers are *not* reset when rows are deleted
    -   In part so that they can be used as primary keys

## Exercise {: .exercise}

Are you able to modify the values stored in `sqlite_sequence`?
In particular,
are you able to reset the values so that
the same sequence numbers are generated again?

## Altering Tables

[%inc alter_tables.sql mark=keep %]
[%inc alter_tables.out %]

-   Add a column after the fact
-   Since it can't be null, we have to provide a default value
    -   Really want to make it the primary key, but SQLite doesn't allow that after the fact
-   Then use `update` to modify existing records
    -   Can modify any number of records at once
    -   So be careful about `where` clause
-   An example of [%g data_migration "data migration" %]

## M-to-N Relationships {: .aside}

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

## Creating New Tables from Old

[%inc insert_select.sql mark=keep %]
[%inc insert_select.out %]

-   `new_work` is our join table
-   Each column refers to a record in some other table

## Removing Tables

[%inc drop_table.sql mark=keep %]
[%inc drop_table.out %]

-   Remove the old table and rename the new one to take its place
    -   Note `if exists`
-   Please back up your data first

## Exercise {: .exercise}

1.  Reorganize the penguins database:
    1.  Make a copy of the `penguins.db` file
        so that your changes won't affect the original.
    2.  Write a SQL script that reorganizes the data into three tables:
        one for each island.
    3.  Why is organizing data like this a bad idea?

2.  Tools like [Sqitch][sqitch] can manage changes to database schemas and data
    so that they can be saved in version control
    and rolled back if they are unsuccessful.
    Translate the changes made by the scripts above into Sqitch.
    Note: this exercise may take an hour or more.
