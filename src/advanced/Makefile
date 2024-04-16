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

all_jobs_check.out: all_jobs_check.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

bidirectional.out: bidirectional.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

rollback_constraint.out: rollback_constraint.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

rollback_statement.out: rollback_statement.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

trigger_firing.out: trigger_firing.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

update_group_ids.out: update_group_ids.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

upsert.out: upsert.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

views.out: views.sql
	cp ${DB}/penguins.db /tmp
	cat ${MODE} $< | ${PENGUINS_TMP} > $@

.PHONY: settings
settings: root_settings
