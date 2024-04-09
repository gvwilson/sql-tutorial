include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

%.out: %.sql
	cat ${MODE} $< | ${MEMORY} > $@

.PHONY: settings
settings: root_settings
