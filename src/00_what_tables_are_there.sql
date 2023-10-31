/*
 ## Our Database

 The commands to manage a database vary significantly from one DB
 manager to another. We are using SQLite, which has over 60 special
 commands. Let's start by showing the *schema* of our sample database,
 which is a fancy word for "what tables exist and what they contain".
*/

.schema

/*
 The output should show 6 tables with the following columns (all of
 which are of type `text`):

| table       | contains                     | column    | purpose                  |
| ----------- | ---------------------------- | ----------| ------------------------ |
| machines    | Machines in lab              | mach_id   | unique ID                |
|             |                              | mach_name | machine's name           |
|             |                              | acquired  | purchase date            |
| scientists  | Scientists in lab            | sci_id    | unique ID                |
|             |                              | personal  | personal name            |
|             |                              | family    | family name              |
|             |                              | hired     | hire date                |
| experiments | Kinds of experiments         | exp_id    | unique ID                |
|             |                              | exp_name  | experiment name          |
|             |                              | exp_date  | date of experiment       |
| performed   | Who performed experiments    | sci_id    | scientist key            |
|             |                              | exp_id    | experiment key           |
| used        | Machines used in experiments | mach_id   | machine key              |
|             |                              | exp_id    | experiment key           |
| notes       | Notes about experiments      | exp_id    | experiment key           |
|             |                              | note      | comment about experiment |

SQLite displays each table by showing the SQL used to create it, e.g.,
the `notes` table is shown as:

```sql
CREATE TABLE notes(
       exp_id text not null,     -- experiment key
       note text not null        -- comment about experiment
);
```
*/
