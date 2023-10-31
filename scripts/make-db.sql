-- Do everything with CSV.
.mode csv

-- Machines used in experiments.
drop table if exists machines;
create table machines(
       mach_id text not null,	-- unique ID
       mach_name text not null,	-- machine's name
       acquired text		-- purchase date (if known)
);
.import data/machines.csv machines

-- Scientists doing experiments.
drop table if exists scientists;
create table scientists(
       sci_id text not null,	-- unique ID
       personal text not null,	-- personal name
       family text not null,	-- family name
       hired text      		-- hire date (if known)
);
.import data/scientists.csv scientists
update scientists set hired=null where hired="";

-- Kinds of experiments.
drop table if exists experiments;
create table experiments(
       exp_id text not null,	-- unique ID
       exp_name text not null,	-- experiment's name
       exp_date text not null	-- date of experiment
);
.import data/experiments.csv experiments

-- Who performed which experiments.
drop table if exists performed;
create table performed(
       sci_id text not null,	-- scientist key
       exp_id text not null	-- experiment key
);
.import data/performed.csv performed

-- Which machines were used in which experiments.
drop table if exists used;
create table used(
       exp_id text not null,	-- experiment key
       mach_id text not null	-- machine key
);
.import data/used.csv used

-- Notes about experiments.
drop table if exists notes;
create table notes(
       exp_id text not null,	-- experiment key
       note text not null    	 	-- comment about experiment
);
.import data/notes.csv notes
