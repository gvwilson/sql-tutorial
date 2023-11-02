/*
Real data is always messy, and one of the things that makes it so is
missing values. SQL represents "holes" in the data with a special
value called `NULL`. It is not zero, false, or the empty string: it is
a marker saying, "We don't know what value should be here."

Let's ask SQLite to show nulls explicitly as well as displaying data
in tables:
*/

.mode table
.nullvalue NULL

/*
If we take a look at the scientists now, we see that Grace Barshan's
hiring date is missing:
*/

select * from scientists;

/*
Since Dr. Barshan's hiring date is unknown, `hired >= "2022-01-01"` is
also unknown. And since "unknown" isn't the same as "true", the record
for Dr. Barshan isn't included when we ask for people hired in or
after 2022. Similarly, `hired < "2022-01-01"` is also unknown, so her
record isn't shown when we ask for people hired before 2022.

Nulls are infectious: if any part of an expression is null, the result
is usually null as well. (We'll look at exceptions in a moment.) To
show this, let's do a little bit of arithmetic:
*/

select 1 + 2;

/*
(Yes, it's weird to "select" an expression without a table, but that's
the syntax that SQL uses.) Now let's try adding 2 and `NULL`:
*/

select 2 + NULL;

/*
Since we don't know what the right side of the addition is, we don't
know what the result is. We get the same answer when we compare
values:
*/

select 2 = NULL;

/*
Here's one that many people find surprising:
*/

select NULL = NULL;

/*
Since we don't know what value is on the right, *and* we don't know
what value is on the left, we can't tell if the two values are equal.
This means that we can't select rows from a table that have nulls
using `=`:
*/

select * from scientists where hired = null;

/*
Instead, SQL gives us two special tests. The first, `is null`, checks
for nulls:
*/

select * from scientists where hired is null;

/*
and the second, `is not null`, checks for non-null values:
*/

select * from scientists where hired is not null;

/*
Some programmers dislike `NULL` so much that they use some other value
in its place, such as -1, 9999, or even `"null"`. *Don't do this.* The
holes in your data won't magically go away if you put a wig and
sunglasses on them, and your SQL will be a lot harder to understand if
people have to figure out what oddball convention you've adopted.
*/
