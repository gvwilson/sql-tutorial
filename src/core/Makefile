include ../../examples.mk

EXCLUDED_SQL := \
    create_work_job.sql \
    populate_work_job.sql \
    update_work_job.sql
SRC := $(filter-out ${EXCLUDED_SQL},$(wildcard *.sql))
OUT := $(patsubst %.sql,%.out,${SRC})

.PHONY: all
all: ${OUT}

admin_commands.out: admin_commands.sql
	cat $< | ${PENGUINS} > $@

aggregate_join.out: aggregate_join.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

aggregate_left_join.out: aggregate_left_join.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

backing_up.out: backing_up.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

coalesce.out: coalesce.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

cross_join.out: cross_join.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

delete_rows.out: delete_rows.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

full_outer_join.out: full_outer_join.sql
	cat ${MODE} $< | ${MEMORY} > $@

inner_join.out: inner_join.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

left_join.out: left_join.sql ${EXCLUDED_SQL}
	cat ${MODE} $< | ${MEMORY} > $@

select_1.out: select_1.sql
	cat $< | ${PENGUINS} > $@

select_star.out: select_star.sql
	cat $< | ${PENGUINS} > $@

%.out: %.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: settings
settings: root_settings
