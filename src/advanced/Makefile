include ../../examples.mk

EXCLUDED_SQL := \
    create_penguins.sql \
    lineage_setup.sql \
    make_active.sql \
    trigger_setup.sql
SRC := $(filter-out ${EXCLUDED_SQL},$(wildcard *.sql))
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

active_penguins.out: active_penguins.sql
	cp ${DB}/penguins.db /tmp
	cat ${MODE} $< | ${PENGUINS_TMP} > $@

all_jobs.out: all_jobs.sql
	cat ${MODE} $< | ${MEMORY} > $@

all_jobs_check.out: all_jobs_check.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

bidirectional.out: bidirectional.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

blob.out: blob.sql
	cat ${MODE} $< | ${MEMORY} > $@

contact_contacts.out: contact_contacts.sql
	cat ${MODE} $< | ${CONTACTS} > $@

contact_person.out: contact_person.sql
	cat ${MODE} $< | ${CONTACTS} > $@

count_penguins.out: count_penguins.sql
	cat ${MODE} $< | ${PENGUINS} > $@

lineage_setup.out: lineage_setup.sql
	cat ${MODE} $< | ${CONTACTS} > $@

recursive_labeling.out: recursive_labeling.sql
	cat ${MODE} $< | ${CONTACTS} > $@

recursive_lineage.out: recursive_lineage.sql
	cat ${MODE} $< | ${MEMORY} > $@

represent_graph.out: represent_graph.sql
	cat ${MODE} $< | ${MEMORY} > $@

rollback_constraint.out: rollback_constraint.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

rollback_statement.out: rollback_statement.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

transaction.out: transaction.sql
	cat ${MODE} $< | ${MEMORY} > $@

trigger_firing.out: trigger_firing.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

trigger_setup.out: trigger_setup.sql
	cat ${MODE} $< | ${MEMORY} > $@

trigger_successful.out: trigger_successful.sql
	cat ${MODE} $< | ${MEMORY} > $@

update_group_ids.out: update_group_ids.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

upsert.out: upsert.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

views.out: views.sql
	cp ${DB}/penguins.db /tmp
	cat ${MODE} $< | ${PENGUINS_TMP} > $@

%.out: %.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

.PHONY: settings
settings: root_settings
