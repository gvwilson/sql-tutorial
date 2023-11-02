/*
Suppose we want to know which scientists performed which experiments.
The scientists' names are in one table, while the experiments are in
another. To bring this information together, we use a *join*. The
simplest join is called an *inner* join* and matches rows from one
table to rows from another like this:
*/

.mode table

select *
from scientists inner join performed;

/*
There are 4 rows in `scientists` and 10 in `performed`, so our output
has 40 rows. Most of these aren't useful because they match scientists
with experiments they didn't perform. To make the output more useful,
we can restrict the matching:
*/

select *
from scientists inner join performed
on scientists.sci_id = performed.sci_id;

/*
Each row now shows a scientist with an experiment they performed.
Notice that we use *table.column* to refer to columns in the
condition, such as `scientists.sci_id`. Without this, our query would
be ambiguous: SQLite would know if `sci_id` referred to the value from
`scientists` or the value from `performed`.

We can slim down the output by selecting columns from the joined
table:
*/

select
    scientists.personal,
    scientists.family,
    performed.exp_id
from scientists inner join performed
on scientists.sci_id = performed.sci_id;

/*
To get the name of the experiment instead of its ID, we just add
another table to the join (and another column to the output):
*/


select
    scientists.personal,
    scientists.family,
    experiments.exp_name,
    experiments.exp_date
from scientists inner join performed inner join experiments
on (scientists.sci_id = performed.sci_id) and (performed.exp_id = experiments.exp_id);
