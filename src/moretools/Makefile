include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

assay_staff.out: assay_staff.sql
	cat ${MODE} $< | ${ASSAYS} > $@

like_glob.out: like_glob.sql
	cat ${MODE} $< | ${ASSAYS} > $@

%.out: %.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: settings
settings: root_settings
