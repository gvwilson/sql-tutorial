include ../../examples.mk

SRC := $(wildcard *.sql)
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

admin_commands.out: admin_commands.sql
	cat $< | ${PENGUINS} > $@

select_1.out: select_1.sql
	cat $< | ${PENGUINS} > $@

select_star.out: select_star.sql
	cat $< | ${PENGUINS} > $@

%.out: %.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: settings
settings: root_settings
