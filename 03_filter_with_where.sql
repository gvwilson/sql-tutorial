.mode table

/*
 We often want to work with a subset of our data, so SQL lets us
 *filter* the records we select by adding a `where` clause to our
 query. The `where` clause must have a single condition that is either
 true or false for each record; only those records for which the
 condition is true are returned.

 Let's find everyone who was hired in or after 2022:
*/

select * from scientists
where hired >= "2022-01-01";

/*
 What about everyone who was hired *before* 2022?
*/

select * from scientists
where hired < "2022-01-01";

/*
 But wait: there are four scientists in the lab, but only three in
 the output of the two queries above. Where is Grace Barshan?
*/
