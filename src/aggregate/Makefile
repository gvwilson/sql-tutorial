include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

%.out: %.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: settings
settings: root_settings
