include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

alter_tables.out: alter_tables.sql
	cat ${MODE} $< | ${MEMORY} &> $@

autoincrement.out: autoincrement.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

create_use_index.out: create_use_index.sql
	cp ${DB}/assays.db /tmp
	cat ${MODE} $< | ${ASSAYS_TMP} > $@

drop_table.out: drop_table.sql
	cat ${MODE} $< | ${MEMORY} &> $@

insert_select.out: insert_select.sql
	cat ${MODE} $< | ${MEMORY} &> $@

primary_key.out: primary_key.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

set_membership.out: set_membership.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

subquery_set.out: subquery_set.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

.PHONY: settings
settings: root_settings
