include ../../examples.mk

EXCLUDED_SQL := \
    create_work_job.sql \
    populate_work_job.sql \
    update_work_job.sql
SRC := $(filter-out ${EXCLUDED_SQL},$(wildcard *.sql))
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

%.out: %.sql
	cat ${MODE} $< | ${MEMORY} > $@

.PHONY: settings
settings: root_settings
