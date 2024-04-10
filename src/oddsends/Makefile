include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

create_use_index.out: create_use_index.sql
	cp ${DB}/assays.db /tmp
	cat ${MODE} $< | ${ASSAYS_TMP} > $@

data_range_sequence.out: data_range_sequence.sql
	cat ${MODE} $< | ${MEMORY} > $@

%.out: %.sql
	cat ${MODE} $< | ${ASSAYS} > $@

.PHONY: settings
settings: root_settings
