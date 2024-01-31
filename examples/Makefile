SQLITE := sqlite3
DATA := ../data
MODE := mode.txt

ASSAYS := ${SQLITE} ${DATA}/assays.db
CONTACTS := ${SQLITE} ${DATA}/contact_tracing.db
CONTACTS_TMP := ${SQLITE} /tmp/contact_tracing.db
LAB_LOG := ${SQLITE} ${DATA}/lab_log.db
MEMORY := ${SQLITE} :memory:
PENGUINS := ${SQLITE} ${DATA}/penguins.db
PENGUINS_TMP := ${SQLITE} /tmp/penguins.db

SQL_FILES := $(wildcard *.sql)
PY_FILES := $(wildcard *.py)
EXCLUDED_FILES := \
  lineage_setup.out \
  trigger_setup.out
OUT_FILES := \
    $(filter-out ${EXCLUDED_FILES},$(patsubst %.sql,%.out,${SQL_FILES})) \
    $(filter-out ${EXCLUDED_FILES},$(patsubst %.py,%.out,${PY_FILES}))

all: ${OUT_FILES}

select_1.out: select_1.sql
	cat $^ | ${PENGUINS} >& $@

select_star.out: select_star.sql
	cat $^ | ${PENGUINS} | head -n 10 >& $@

admin_commands.out: admin_commands.sql
	cat $^ | ${PENGUINS} | head -n 10 >& $@

specify_columns.out: specify_columns.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 12 >& $@

sort.out: sort.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 12 >& $@

limit.out: limit.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 7 >& $@

page.out: page.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 7 >& $@

distinct.out: distinct.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

filter.out: filter.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 7 >& $@

filter_and.out: filter_and.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

calculations.out: calculations.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

rename_columns.out: rename_columns.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

show_missing_values.out: show_missing_values.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

null_equality.out: null_equality.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

null_inequality.out: null_inequality.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

ternary_logic.out: ternary_logic.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

safe_null_equality.out: safe_null_equality.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

simple_sum.out: simple_sum.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

common_aggregations.out: common_aggregations.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

simple_group.out: simple_group.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

unaggregated_columns.out: unaggregated_columns.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

arbitrary_in_aggregation.out: arbitrary_in_aggregation.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

filter_aggregation.out: filter_aggregation.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

readable_aggregation.out: readable_aggregation.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

filter_aggregate_inputs.out: filter_aggregate_inputs.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

create_tables.out: create_tables.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

insert_values.out: create_tables.sql insert_values.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

update_rows.out: create_tables.sql update_rows.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

delete_rows.out: create_tables.sql delete_rows.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

backing_up.out: create_tables.sql backing_up.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

cross_join.out: create_tables.sql cross_join.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

inner_join.out: create_tables.sql inner_join.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

aggregate_join.out: create_tables.sql aggregate_join.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

left_join.out: create_tables.sql left_join.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

aggregate_left_join.out: create_tables.sql aggregate_left_join.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

coalesce.out: create_tables.sql coalesce.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

negate_incorrectly.out: create_tables.sql negate_incorrectly.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

set_membership.out: create_tables.sql set_membership.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

subquery_set.out: create_tables.sql subquery_set.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

autoincrement.out: autoincrement.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

sequence_table.out: sequence_table.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

alter_tables.out: alter_tables.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

insert_select.out: insert_select.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

drop_table.out: drop_table.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

compare_individual_aggregate.out: compare_individual_aggregate.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

compare_within_groups.out: compare_within_groups.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

common_table_expressions.out: common_table_expressions.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

explain_query_plan.out: explain_query_plan.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

rowid.out: rowid.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

if_else.out: if_else.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

case_when.out: case_when.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

select_range.out: select_range.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

assay_staff.out: assay_staff.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

like_glob.out: like_glob.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

union_all.out: union_all.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

intersect.out: intersect.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

except.out: except.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

random_numbers.out: random_numbers.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

generate_sequence.out: generate_sequence.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

data_range_sequence.out: data_range_sequence.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

date_sequence.out: date_sequence.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

experiments_per_day.out: experiments_per_day.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

self_join.out: self_join.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

unique_pairs.out: unique_pairs.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

filter_pairs.out: filter_pairs.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

correlated_subquery.out: correlated_subquery.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

nonexistence.out: nonexistence.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

avoid_correlated_subqueries.out: avoid_correlated_subqueries.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

lead_lag.out: lead_lag.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

window_functions.out: window_functions.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

explain_window_function.out: explain_window_function.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

partition_window.out: partition_window.sql
	cat ${MODE} $^ | ${ASSAYS} >& $@

blob.out: blob.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

lab_log_schema.out: lab_log_schema.sql
	cat ${MODE} $^ | ${LAB_LOG} >& $@

json_in_table.out: json_in_table.sql
	cat ${MODE} $^ | ${LAB_LOG} >& $@

json_field.out: json_field.sql
	cat ${MODE} $^ | ${LAB_LOG} >& $@

json_array.out: json_array.sql
	cat ${MODE} $^ | ${LAB_LOG} >& $@

json_array_last.out: json_array_last.sql
	cat ${MODE} $^ | ${LAB_LOG} >& $@

json_modify.out: json_modify.sql
	cat ${MODE} $^ | ${LAB_LOG} >& $@

count_penguins.out: count_penguins.sql
	cat ${MODE} $^ | ${PENGUINS} >& $@

active_penguins.out: active_penguins.sql
	cp ${DATA}/penguins.db /tmp
	cat ${MODE} $^ | ${PENGUINS_TMP} >& $@

all_jobs.out: all_jobs.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

all_jobs_check.out: all_jobs_check.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

transaction.out: transaction.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

rollback_constraint.out: rollback_constraint.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

rollback_statement.out: rollback_statement.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

trigger_successful.out: trigger_successful.sql trigger_setup.sql
	cat ${MODE} $< | ${MEMORY} >& $@

trigger_firing.out: trigger_firing.sql trigger_setup.sql
	cat ${MODE} $< | ${MEMORY} >& $@

represent_graph.out: represent_graph.sql
	cat ${MODE} $^ | ${MEMORY} >& $@

contact_person.out: contact_person.sql
	cat ${MODE} $^ | {CONTACTS} >& $@

contact_contacts.out: contact_contacts.sql
	cat ${MODE} $^ | {CONTACTS} >& $@

bidirectional.out: bidirectional.sql
	cp ${DATA}/contact_tracing.db /tmp
	cat ${MODE} $^ | {CONTACTS_TMP} >& $@

update_group_ids.out: update_group_ids.sql
	cp ${DATA}/contact_tracing.db /tmp
	cat ${MODE} $^ | {CONTACTS_TMP} >& $@

recursive_labeling.out: recursive_labeling.sql
	cp ${DATA}/contact_tracing.db /tmp
	cat ${MODE} $^ | {CONTACTS_TMP} >& $@

basic_python_query.out: basic_python_query.py
	python $< > $@

incremental_fetch.out: incremental_fetch.py
	python $< > $@

insert_delete.out: insert_delete.py
	python $< > $@

interpolate.out: interpolate.py
	python $< > $@

script_execution.out: script_execution.py
	python $< > $@

exceptions.out: exceptions.py
	python $< > $@

embedded_python.out: embedded_python.py
	python $< > $@

dates_times.out: dates_times.py
	python $< > $@

select_pandas.out: select_pandas.py
	python $< > $@

select_polars.out: select_polars.py
	python $< > $@

orm.out: orm.py
	python $< > $@

orm_relation.out: orm_relation.py
	python $< > $@
