include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

alter_tables.out: alter_tables.sql
	cat ${MODE} $< | ${MEMORY} &> $@

assay_staff.out: assay_staff.sql
	cat ${MODE} $< | ${ASSAYS} > $@

autoincrement.out: autoincrement.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

avoid_correlated_subqueries.out: avoid_correlated_subqueries.sql
	cat ${MODE} $< | ${ASSAYS} > $@

correlated_subquery.out: correlated_subquery.sql
	cat ${MODE} $< | ${ASSAYS} > $@

create_use_index.out: create_use_index.sql
	cp ${DB}/assays.db /tmp
	cat ${MODE} $< | ${ASSAYS_TMP} > $@

data_range_sequence.out: data_range_sequence.sql
	cat ${MODE} $< | ${MEMORY} > $@

date_sequence.out: date_sequence.sql
	cat ${MODE} $< | ${ASSAYS} > $@

drop_table.out: drop_table.sql
	cat ${MODE} $< | ${MEMORY} &> $@

except.out: except.sql
	cat ${MODE} $< | ${ASSAYS} > $@

experiments_per_day.out: experiments_per_day.sql
	cat ${MODE} $< | ${ASSAYS} > $@

explain_window_function.out: explain_window_function.sql
	cat ${MODE} $< | ${ASSAYS} > $@

filter_pairs.out: filter_pairs.sql
	cat ${MODE} $< | ${ASSAYS} > $@

generate_sequence.out: generate_sequence.sql
	cat ${MODE} $< | ${ASSAYS} > $@

insert_select.out: insert_select.sql
	cat ${MODE} $< | ${MEMORY} &> $@

intersect.out: intersect.sql
	cat ${MODE} $< | ${ASSAYS} > $@

lead_lag.out: lead_lag.sql
	cat ${MODE} $< | ${ASSAYS} > $@

like_glob.out: like_glob.sql
	cat ${MODE} $< | ${ASSAYS} > $@

negate_incorrectly.out: negate_incorrectly.sql
	cat ${MODE} $< | ${MEMORY} > $@

nonexistence.out: nonexistence.sql
	cat ${MODE} $< | ${ASSAYS} > $@

partition_window.out: partition_window.sql
	cat ${MODE} $< | ${ASSAYS} > $@

primary_key.out: primary_key.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

random_numbers.out: random_numbers.sql
	cat ${MODE} $< | ${ASSAYS} > $@

sequence_table.out: sequence_table.sql
	cat ${MODE} $< | ${MEMORY} > $@

self_join.out: self_join.sql
	cat ${MODE} $< | ${ASSAYS} > $@

set_membership.out: set_membership.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

subquery_set.out: subquery_set.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

union_all.out: union_all.sql
	cat ${MODE} $< | ${ASSAYS} > $@

unique_pairs.out: unique_pairs.sql
	cat ${MODE} $< | ${ASSAYS} > $@

window_functions.out: window_functions.sql
	cat ${MODE} $< | ${ASSAYS} > $@

%.out: %.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: settings
settings: root_settings
