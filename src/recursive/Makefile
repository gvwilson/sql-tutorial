include ../../examples.mk

EXCLUDED_SQL := \
    lineage_setup.sql
SRC := $(filter-out ${EXCLUDED_SQL},$(wildcard *.sql))
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

bidirectional.out: bidirectional.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

recursive_lineage.out: recursive_lineage.sql
	cat ${MODE} $< | ${MEMORY} > $@

represent_graph.out: represent_graph.sql
	cat ${MODE} $< | ${MEMORY} > $@

update_group_ids.out: update_group_ids.sql
	cp ${DB}/contact_tracing.db /tmp
	cat ${MODE} $< | ${CONTACTS_TMP} > $@

%.out: %.sql
	cat ${MODE} $< | ${CONTACTS} > $@

.PHONY: settings
settings: root_settings
