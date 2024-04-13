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

select_1.out: select_1.sql
	cat $< | ${PENGUINS} > $@

select_star.out: select_star.sql
	cat $< | ${PENGUINS} > $@

aggregate_join.out: ${EXCLUDED_SQL}
aggregate_left_join.out: ${EXCLUDED_SQL}
backing_up.out: ${EXCLUDED_SQL}
coalesce.out: ${EXCLUDED_SQL}
cross_join.out: ${EXCLUDED_SQL}
delete_rows.out: ${EXCLUDED_SQL}
inner_join.out: ${EXCLUDED_SQL}
left_join.out: ${EXCLUDED_SQL}
show_after_update.out: ${EXCLUDED_SQL}
show_work_job.out: ${EXCLUDED_SQL}

%.out: %.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: settings
settings: root_settings
