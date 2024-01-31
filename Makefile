DATA := examples/data

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## databases: make required files
.PHONY: databases
databases : \
	${DATA}/assays.db \
	${DATA}/contact_tracing.db \
	${DATA}/lab_log.db \
	${DATA}/penguins.db

## examples/data/assays.db: synthetic experimental data
${DATA}/assays.db: bin/create_assays_db.py
	python $< $@

## examples/data/contact_tracing.db: synthetic contact tracing
${DATA}/contact_tracing.db: bin/create_contacts.py
	python $< $@

## examples/data/lab_log.db: synthetic experiment records
${DATA}/lab_log.db: bin/create_lab_log.py
	python $< $@

## examples/data/penguins.db: penguin data
${DATA}/penguins.db : bin/create_penguins_db.sql ${DATA}/penguins.csv
	sqlite3 $@ < $<

## lint: check project state
.PHONY: lint
lint:
	@python bin/check_examples.py ./examples

## keywords: list unused keywords
.PHONY: keywords
keywords:
	@python bin/get_sql_features.py --diff _data/sql_keywords.txt --markdown < index.md

## renumber: renumber headings
.PHONY: renumber
renumber:
	@python bin/renumber_headings.py index.md

## clean: clean up stray files
.PHONY: clean
clean:
	@rm -f *~
	@rm -rf _site

# ----------------------------------------------------------------------

SQLITE := sqlite3
X := examples
MODE := ${X}/mode.txt
DATA := ${X}/data

ASSAYS := ${SQLITE} ${DATA}/assays.db
CONTACTS := ${SQLITE} ${DATA}/contact_tracing.db
CONTACTS_TMP := ${SQLITE} /tmp/contact_tracing.db
LAB_LOG := ${SQLITE} ${DATA}/lab_log.db
MEMORY := ${SQLITE} :memory:
PENGUINS := ${SQLITE} ${DATA}/penguins.db
PENGUINS_TMP := ${SQLITE} /tmp/penguins.db

SQL_FILES := $(wildcard ${X}/*.sql)
PY_FILES := $(wildcard ${X}/*.py)
EXCLUDED_FILES := \
  ${X}/lineage_setup.out \
  ${X}/trigger_setup.out
OUT_FILES := \
    $(filter-out ${EXCLUDED_FILES},$(patsubst %.sql,%.out,${SQL_FILES})) \
    $(filter-out ${EXCLUDED_FILES},$(patsubst %.py,%.out,${PY_FILES}))

## run: re-run all examples
.PHONY: run
run: ${OUT_FILES}

${X}/select_1.out: ${X}/select_1.sql
	cat $^ | ${PENGUINS} > $@

${X}/select_star.out: ${X}/select_star.sql
	cat $^ | ${PENGUINS} | head -n 10 > $@

${X}/admin_commands.out: ${X}/admin_commands.sql
	cat $^ | ${PENGUINS} | head -n 10 > $@

${X}/specify_columns.out: ${X}/specify_columns.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 12 > $@

${X}/sort.out: ${X}/sort.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 12 > $@

${X}/limit.out: ${X}/limit.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 7 > $@

${X}/page.out: ${X}/page.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 7 > $@

${X}/distinct.out: ${X}/distinct.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/filter.out: ${X}/filter.sql
	cat ${MODE} $^ | ${PENGUINS} | head -n 7 > $@

${X}/filter_and.out: ${X}/filter_and.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/calculations.out: ${X}/calculations.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/rename_columns.out: ${X}/rename_columns.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/show_missing_values.out: ${X}/show_missing_values.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/null_equality.out: ${X}/null_equality.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/null_inequality.out: ${X}/null_inequality.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/ternary_logic.out: ${X}/ternary_logic.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/safe_null_equality.out: ${X}/safe_null_equality.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/simple_sum.out: ${X}/simple_sum.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/common_aggregations.out: ${X}/common_aggregations.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/simple_group.out: ${X}/simple_group.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/unaggregated_columns.out: ${X}/unaggregated_columns.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/arbitrary_in_aggregation.out: ${X}/arbitrary_in_aggregation.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/filter_aggregation.out: ${X}/filter_aggregation.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/readable_aggregation.out: ${X}/readable_aggregation.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/filter_aggregate_inputs.out: ${X}/filter_aggregate_inputs.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/create_tables.out: ${X}/create_tables.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/insert_values.out: ${X}/create_tables.sql ${X}/insert_values.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/update_rows.out: ${X}/create_tables.sql ${X}/update_rows.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/delete_rows.out: ${X}/create_tables.sql ${X}/delete_rows.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/backing_up.out: ${X}/create_tables.sql ${X}/backing_up.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/cross_join.out: ${X}/create_tables.sql ${X}/cross_join.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/inner_join.out: ${X}/create_tables.sql ${X}/inner_join.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/aggregate_join.out: ${X}/create_tables.sql ${X}/aggregate_join.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/left_join.out: ${X}/create_tables.sql ${X}/left_join.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/aggregate_left_join.out: ${X}/create_tables.sql ${X}/aggregate_left_join.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/coalesce.out: ${X}/create_tables.sql ${X}/coalesce.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/negate_incorrectly.out: ${X}/create_tables.sql ${X}/negate_incorrectly.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/set_membership.out: ${X}/create_tables.sql ${X}/set_membership.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/subquery_set.out: ${X}/create_tables.sql ${X}/subquery_set.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/autoincrement.out: ${X}/autoincrement.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/sequence_table.out: ${X}/sequence_table.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/alter_tables.out: ${X}/alter_tables.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/insert_select.out: ${X}/insert_select.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/drop_table.out: ${X}/drop_table.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/compare_individual_aggregate.out: ${X}/compare_individual_aggregate.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/compare_within_groups.out: ${X}/compare_within_groups.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/common_table_expressions.out: ${X}/common_table_expressions.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/explain_query_plan.out: ${X}/explain_query_plan.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/rowid.out: ${X}/rowid.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/if_else.out: ${X}/if_else.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/case_when.out: ${X}/case_when.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/select_range.out: ${X}/select_range.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/assay_staff.out: ${X}/assay_staff.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/like_glob.out: ${X}/like_glob.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/union_all.out: ${X}/union_all.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/intersect.out: ${X}/intersect.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/except.out: ${X}/except.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/random_numbers.out: ${X}/random_numbers.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/generate_sequence.out: ${X}/generate_sequence.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/data_range_sequence.out: ${X}/data_range_sequence.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/date_sequence.out: ${X}/date_sequence.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/experiments_per_day.out: ${X}/experiments_per_day.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/self_join.out: ${X}/self_join.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/unique_pairs.out: ${X}/unique_pairs.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/filter_pairs.out: ${X}/filter_pairs.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/correlated_subquery.out: ${X}/correlated_subquery.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/nonexistence.out: ${X}/nonexistence.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/avoid_correlated_subqueries.out: ${X}/avoid_correlated_subqueries.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/lead_lag.out: ${X}/lead_lag.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/window_functions.out: ${X}/window_functions.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/explain_window_function.out: ${X}/explain_window_function.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/partition_window.out: ${X}/partition_window.sql
	cat ${MODE} $^ | ${ASSAYS} > $@

${X}/blob.out: ${X}/blob.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/lab_log_schema.out: ${X}/lab_log_schema.sql
	cat ${MODE} $^ | ${LAB_LOG} > $@

${X}/json_in_table.out: ${X}/json_in_table.sql
	cat ${MODE} $^ | ${LAB_LOG} > $@

${X}/json_field.out: ${X}/json_field.sql
	cat ${MODE} $^ | ${LAB_LOG} > $@

${X}/json_array.out: ${X}/json_array.sql
	cat ${MODE} $^ | ${LAB_LOG} > $@

${X}/json_array_last.out: ${X}/json_array_last.sql
	cat ${MODE} $^ | ${LAB_LOG} > $@

${X}/json_modify.out: ${X}/json_modify.sql
	cat ${MODE} $^ | ${LAB_LOG} > $@

${X}/count_penguins.out: ${X}/count_penguins.sql
	cat ${MODE} $^ | ${PENGUINS} > $@

${X}/active_penguins.out: ${X}/active_penguins.sql
	cp ${DATA}/penguins.db /tmp
	cat ${MODE} $^ | ${PENGUINS_TMP} > $@

${X}/all_jobs.out: ${X}/all_jobs.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/all_jobs_check.out: ${X}/all_jobs_check.sql
	-cat ${MODE} $^ | ${MEMORY} &> $@

${X}/transaction.out: ${X}/transaction.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/rollback_constraint.out: ${X}/rollback_constraint.sql
	-cat ${MODE} $^ | ${MEMORY} >& $@

${X}/rollback_statement.out: ${X}/rollback_statement.sql
	-cat ${MODE} $^ | ${MEMORY} >& $@

${X}/trigger_successful.out: ${X}/trigger_successful.sql ${X}/trigger_setup.sql
	cat ${MODE} $< | ${MEMORY} > $@

${X}/trigger_firing.out: ${X}/trigger_firing.sql ${X}/trigger_setup.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

${X}/represent_graph.out: ${X}/represent_graph.sql
	cat ${MODE} $^ | ${MEMORY} > $@

${X}/contact_person.out: ${X}/contact_person.sql
	cat ${MODE} $^ | ${CONTACTS} > $@

${X}/contact_contacts.out: ${X}/contact_contacts.sql
	cat ${MODE} $^ | ${CONTACTS} > $@

${X}/bidirectional.out: ${X}/bidirectional.sql
	cp ${DATA}/contact_tracing.db /tmp
	cat ${MODE} $^ | ${CONTACTS_TMP} > $@

${X}/update_group_ids.out: ${X}/update_group_ids.sql
	cp ${DATA}/contact_tracing.db /tmp
	cat ${MODE} $^ | ${CONTACTS_TMP} > $@

${X}/recursive_labeling.out: ${X}/recursive_labeling.sql
	cat ${MODE} $^ | ${CONTACTS} > $@

${X}/basic_python_query.out: ${X}/basic_python_query.py
	python $< > $@

${X}/incremental_fetch.out: ${X}/incremental_fetch.py
	python $< > $@

${X}/insert_delete.out: ${X}/insert_delete.py
	python $< > $@

${X}/interpolate.out: ${X}/interpolate.py
	python $< > $@

${X}/script_execution.out: ${X}/script_execution.py
	python $< > $@

${X}/exceptions.out: ${X}/exceptions.py
	python $< > $@

${X}/embedded_python.out: ${X}/embedded_python.py
	python $< > $@

${X}/dates_times.out: ${X}/dates_times.py
	python $< > $@

${X}/select_pandas.out: ${X}/select_pandas.py
	python $< > $@

${X}/select_polars.out: ${X}/select_polars.py
	python $< > $@

${X}/orm.out: ${X}/orm.py
	python $< > $@

${X}/orm_relation.out: ${X}/orm_relation.py
	python $< > $@
