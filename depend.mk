${OUT}/active_penguins.out: ${SRC}/make_active.sql
${OUT}/aggregate_join.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/aggregate_left_join.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/backing_up.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql ${SRC}/update_work_job.sql
${OUT}/coalesce.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/cross_join.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/delete_rows.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql ${SRC}/update_work_job.sql
${OUT}/inner_join.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/insert_values.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/left_join.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/negate_incorrectly.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/recursive_lineage.out: ${SRC}/lineage_setup.sql
${OUT}/represent_graph.out: ${SRC}/lineage_setup.sql
${OUT}/set_membership.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/subquery_set.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql
${OUT}/trigger_firing.out: ${SRC}/trigger_setup.sql
${OUT}/trigger_successful.out: ${SRC}/trigger_setup.sql
${OUT}/update_rows.out: ${SRC}/create_work_job.sql ${SRC}/populate_work_job.sql ${SRC}/update_work_job.sql
${OUT}/views.out: ${SRC}/make_active.sql
