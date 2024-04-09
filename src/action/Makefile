include ../../examples.mk

EXCLUDED_SQL := \
  trigger_setup.sql
SRC := $(filter-out ${EXCLUDED_SQL},$(wildcard *.sql))
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

all_jobs_check.out: all_jobs_check.sql
	-cat ${MODE} $< | ${MEMORY} &> $@

rollback_constraint.out: rollback_constraint.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

rollback_statement.out: rollback_statement.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

trigger_firing.out: trigger_firing.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

upsert.out: upsert.sql
	-cat ${MODE} $< | ${MEMORY} >& $@

%.out: %.sql
	cat ${MODE} $< | ${MEMORY} > $@

.PHONY: settings
settings: root_settings
