include ../../examples.mk

NEW_ROLE = penguin_reader_writer
DB_NAME  = penguins

# To simulate the scenario of this tutorial we have to:
# - 1. Create a new role (run scripts as admin to do it)
# - 2. Run some scripts (as the new role)
# - 3. Revoke some privileges from the new role (run script as admin again)
# - 4. Run some scripts (as the new role)
#
# These are implemented in the four recipes below

TO_RUN_AS_ADMIN_FIRST := create_reader_writer.sql \
			             grant_select_update.sql \

TO_RUN_AS_NEW_ROLE_FIRST := select_penguins.sql \
					        update_penguins.sql \
					        delete_penguins.sql \

TO_RUN_AS_ADMIN_SECOND := revoke_update.sql

TO_RUN_AS_NEW_ROLE_SECOND := update_penguins_again.sql 


.PHONY: all run_as_admin_first run_as_new_role_first run_as_admin_second run_as_new_role_second
all: run_as_admin_first run_as_new_role_first run_as_admin_second run_as_new_role_second

run_as_admin_first:
	$(foreach sql, $(TO_RUN_AS_ADMIN_FIRST), psql -d $(DB_NAME) -f $(sql) > $(sql:.sql=.out) 2>&1;)

run_as_new_role_first:
	$(foreach sql, $(TO_RUN_AS_NEW_ROLE_FIRST), psql -U $(NEW_ROLE) -d $(DB_NAME) -f $(sql) > $(sql:.sql=.out) 2>&1;)

run_as_admin_second:
	$(foreach sql, $(TO_RUN_AS_ADMIN_SECOND), psql -d $(DB_NAME) -f $(sql) > $(sql:.sql=.out) 2>&1;)

run_as_new_role_second:
	$(foreach sql, $(TO_RUN_AS_NEW_ROLE_SECOND), psql -U $(NEW_ROLE) -d $(DB_NAME) -f $(sql) > $(sql:.sql=.out) 2>&1;)

.PHONY: settings
settings: root_settings
