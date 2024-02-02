SQLITE := sqlite3
DB := db
SRC := src
OUT := out
MODE := ${SRC}/mode.txt

ASSAYS := ${SQLITE} ${DB}/assays.db
CONTACTS := ${SQLITE} ${DB}/contact_tracing.db
CONTACTS_TMP := ${SQLITE} /tmp/contact_tracing.db
LAB_LOG := ${SQLITE} ${DB}/lab_log.db
MEMORY := ${SQLITE} :memory:
PENGUINS := ${SQLITE} ${DB}/penguins.db
PENGUINS_TMP := ${SQLITE} /tmp/penguins.db

SQL_FILES := $(wildcard ${SRC}/*.sql)
PY_FILES := $(wildcard ${SRC}/*.py)
EXCLUDED_SQL := \
  ${SRC}/create_work_job.sql \
  ${SRC}/lineage_setup.sql \
  ${SRC}/trigger_setup.sql
OUT_FILES := \
    $(patsubst ${SRC}/%.sql,${OUT}/%.out,$(filter-out ${EXCLUDED_SQL},${SQL_FILES})) \
    $(patsubst ${SRC}/%.py,${OUT}/%.out,${PY_FILES})

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## build: rebuild website
.PHONY: build
build:
	@jekyll build

## serve: rebuild and serve website
.PHONY: serve
serve:
	@jekyll serve

## databases: make required files
.PHONY: databases
databases : \
	${DB}/assays.db \
	${DB}/contact_tracing.db \
	${DB}/lab_log.db \
	${DB}/penguins.db

${DB}/assays.db: bin/create_assays_db.py
	python $< $@

${DB}/contact_tracing.db: bin/create_contacts.py
	python $< $@

${DB}/lab_log.db: bin/create_lab_log.py
	python $< $@

${DB}/penguins.db : bin/create_penguins_db.sql misc/penguins.csv
	sqlite3 $@ < $<

## release: create a release
.PHONY: release
release:
	cd ${DB} && zip -r ../sql-tutorial.zip *.db

## lint: check project state
.PHONY: lint
lint:
	@python bin/check_examples.py .

## style: check Python code style
.PHONY: style
style:
	@ruff check .

## reformat: reformat unstylish Python code
.PHONY: reformat
reformat:
	@ruff format .

## missing: list unused keywords
.PHONY: missing
missing:
	@python bin/get_sql_features.py --missing misc/sql_keywords.txt --files ${SQL_FILES}

## used: list used keywords
.PHONY: used
used:
	@python bin/get_sql_features.py --report alpha --files ${SQL_FILES}

## freq: list keywords by frequency
.PHONY: freq
freq:
	@python bin/get_sql_features.py --report freq --files ${SQL_FILES}

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

## run: re-run all examples
.PHONY: run
run: ${OUT_FILES}

${OUT}/select_1.out: ${SRC}/select_1.sql
	cat $< | ${PENGUINS} > $@

${OUT}/select_star.out: ${SRC}/select_star.sql
	cat $< | ${PENGUINS} | head -n 10 > $@

${OUT}/admin_commands.out: ${SRC}/admin_commands.sql
	cat $< | ${PENGUINS} | head -n 10 > $@

${OUT}/specify_columns.out: ${SRC}/specify_columns.sql
	cat ${MODE} $< | ${PENGUINS} | head -n 12 > $@

${OUT}/sort.out: ${SRC}/sort.sql
	cat ${MODE} $< | ${PENGUINS} | head -n 12 > $@

${OUT}/limit.out: ${SRC}/limit.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/page.out: ${SRC}/page.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/distinct.out: ${SRC}/distinct.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/filter.out: ${SRC}/filter.sql
	cat ${MODE} $< | ${PENGUINS} | head -n 7 > $@

${OUT}/filter_and.out: ${SRC}/filter_and.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/calculations.out: ${SRC}/calculations.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/rename_columns.out: ${SRC}/rename_columns.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/show_missing_values.out: ${SRC}/show_missing_values.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/null_equality.out: ${SRC}/null_equality.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/null_inequality.out: ${SRC}/null_inequality.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/ternary_logic.out: ${SRC}/ternary_logic.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/safe_null_equality.out: ${SRC}/safe_null_equality.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/simple_sum.out: ${SRC}/simple_sum.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/common_aggregations.out: ${SRC}/common_aggregations.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/simple_group.out: ${SRC}/simple_group.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/unaggregated_columns.out: ${SRC}/unaggregated_columns.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/arbitrary_in_aggregation.out: ${SRC}/arbitrary_in_aggregation.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/filter_aggregation.out: ${SRC}/filter_aggregation.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/readable_aggregation.out: ${SRC}/readable_aggregation.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/filter_aggregate_inputs.out: ${SRC}/filter_aggregate_inputs.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/show_work_job.out: ${SRC}/show_work_job.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/insert_values.out: ${SRC}/insert_values.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/update_rows.out: ${SRC}/update_rows.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/delete_rows.out: ${SRC}/delete_rows.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/backing_up.out: ${SRC}/backing_up.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/cross_join.out: ${SRC}/cross_join.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/inner_join.out: ${SRC}/inner_join.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/aggregate_join.out: ${SRC}/aggregate_join.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/left_join.out: ${SRC}/left_join.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/aggregate_left_join.out: ${SRC}/aggregate_left_join.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/coalesce.out: ${SRC}/coalesce.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/negate_incorrectly.out: ${SRC}/negate_incorrectly.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/set_membership.out: ${SRC}/set_membership.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/subquery_set.out: ${SRC}/subquery_set.sql ${SRC}/create_work_job.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/autoincrement.out: ${SRC}/autoincrement.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/sequence_table.out: ${SRC}/sequence_table.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/alter_tables.out: ${SRC}/alter_tables.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/insert_select.out: ${SRC}/insert_select.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/drop_table.out: ${SRC}/drop_table.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/compare_individual_aggregate.out: ${SRC}/compare_individual_aggregate.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/compare_within_groups.out: ${SRC}/compare_within_groups.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/common_table_expressions.out: ${SRC}/common_table_expressions.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/explain_query_plan.out: ${SRC}/explain_query_plan.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/rowid.out: ${SRC}/rowid.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/if_else.out: ${SRC}/if_else.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/case_when.out: ${SRC}/case_when.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/select_range.out: ${SRC}/select_range.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/assay_staff.out: ${SRC}/assay_staff.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/like_glob.out: ${SRC}/like_glob.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/union_all.out: ${SRC}/union_all.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/intersect.out: ${SRC}/intersect.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/except.out: ${SRC}/except.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/random_numbers.out: ${SRC}/random_numbers.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/generate_sequence.out: ${SRC}/generate_sequence.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/data_range_sequence.out: ${SRC}/data_range_sequence.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/date_sequence.out: ${SRC}/date_sequence.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/experiments_per_day.out: ${SRC}/experiments_per_day.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/self_join.out: ${SRC}/self_join.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/unique_pairs.out: ${SRC}/unique_pairs.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/filter_pairs.out: ${SRC}/filter_pairs.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/correlated_subquery.out: ${SRC}/correlated_subquery.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/nonexistence.out: ${SRC}/nonexistence.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/avoid_correlated_subqueries.out: ${SRC}/avoid_correlated_subqueries.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/lead_lag.out: ${SRC}/lead_lag.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/window_functions.out: ${SRC}/window_functions.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/explain_window_function.out: ${SRC}/explain_window_function.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/partition_window.out: ${SRC}/partition_window.sql
	cat ${MODE} $< | ${ASSAYS} > $@

${OUT}/blob.out: ${SRC}/blob.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/lab_log_schema.out: ${SRC}/lab_log_schema.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

${OUT}/json_in_table.out: ${SRC}/json_in_table.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

${OUT}/json_field.out: ${SRC}/json_field.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

${OUT}/json_array.out: ${SRC}/json_array.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

${OUT}/json_array_last.out: ${SRC}/json_array_last.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

${OUT}/json_modify.out: ${SRC}/json_modify.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

${OUT}/count_penguins.out: ${SRC}/count_penguins.sql
	cat ${MODE} $< | ${PENGUINS} > $@

${OUT}/active_penguins.out: ${SRC}/active_penguins.sql
	cp ${DB}/penguins.db /tmp
	cat ${MODE} $< | ${PENGUINS_TMP} > $@

${OUT}/all_jobs.out: ${SRC}/all_jobs.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/all_jobs_check.out: ${SRC}/all_jobs_check.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

${OUT}/transaction.out: ${SRC}/transaction.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/rollback_constraint.out: ${SRC}/rollback_constraint.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

${OUT}/rollback_statement.out: ${SRC}/rollback_statement.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

${OUT}/trigger_successful.out: ${SRC}/trigger_successful.sql ${SRC}/trigger_setup.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/trigger_firing.out: ${SRC}/trigger_firing.sql ${SRC}/trigger_setup.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

${OUT}/represent_graph.out: ${SRC}/represent_graph.sql
	cat ${MODE} $< | ${MEMORY} > $@

${OUT}/contact_person.out: ${SRC}/contact_person.sql
	cat ${MODE} $< | ${CONTACTS} > $@

${OUT}/contact_contacts.out: ${SRC}/contact_contacts.sql
	cat ${MODE} $< | ${CONTACTS} > $@

${OUT}/bidirectional.out: ${SRC}/bidirectional.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

${OUT}/update_group_ids.out: ${SRC}/update_group_ids.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

${OUT}/recursive_labeling.out: ${SRC}/recursive_labeling.sql
	cat ${MODE} $< | ${CONTACTS} > $@

${OUT}/basic_python_query.out: ${SRC}/basic_python_query.py
	python $< > $@

${OUT}/incremental_fetch.out: ${SRC}/incremental_fetch.py
	python $< > $@

${OUT}/insert_delete.out: ${SRC}/insert_delete.py
	python $< > $@

${OUT}/interpolate.out: ${SRC}/interpolate.py
	python $< > $@

${OUT}/script_execution.out: ${SRC}/script_execution.py
	python $< > $@

${OUT}/exceptions.out: ${SRC}/exceptions.py
	python $< > $@

${OUT}/embedded_python.out: ${SRC}/embedded_python.py
	python $< > $@

${OUT}/dates_times.out: ${SRC}/dates_times.py
	python $< > $@

${OUT}/select_pandas.out: ${SRC}/select_pandas.py
	python $< > $@

${OUT}/select_polars.out: ${SRC}/select_polars.py
	python $< > $@

${OUT}/orm.out: ${SRC}/orm.py
	python $< > $@

${OUT}/orm_relation.out: ${SRC}/orm_relation.py
	python $< > $@
