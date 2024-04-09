include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

autoincrement.out: autoincrement.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

primary_key.out: primary_key.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

%.out: %.sql
	cat ${MODE} $< | ${MEMORY} > $@

.PHONY: settings
settings: root_settings
