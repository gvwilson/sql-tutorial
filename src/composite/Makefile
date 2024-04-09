include ../../examples.mk

EXCLUDED_SQL := \
    make_active.sql \
    create_penguins.sql
SRC := $(filter-out ${EXCLUDED_SQL},$(wildcard *.sql))
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

active_penguins.out: active_penguins.sql
	cp ${DB}/penguins.db /tmp
	cat ${MODE} $< | ${PENGUINS_TMP} > $@

blob.out: blob.sql
	cat ${MODE} $< | ${MEMORY} > $@

count_penguins.out: count_penguins.sql
	cat ${MODE} $< | ${PENGUINS} > $@

views.out: views.sql
	cp ${DB}/penguins.db /tmp
	cat ${MODE} $< | ${PENGUINS_TMP} > $@

%.out: %.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

.PHONY: settings
settings: root_settings
