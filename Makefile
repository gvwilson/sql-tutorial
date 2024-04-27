include lib/mccole/mccole.mk

## databases: make required files
.PHONY: databases
databases : \
	${DB}/assays.db \
	${DB}/contact_tracing.db \
	${DB}/lab_log.db \
	${DB}/penguins.db

${DB}/assays.db: bin/create_assays_db.py
	python $< $@

${DB}/contact_tracing.db: bin/create_contacts.py
	python $< $@

${DB}/lab_log.db: bin/create_lab_log.py
	python $< $@

${DB}/penguins.db : bin/create_penguins.py misc/penguins.csv
	python $< $@ misc/penguins.csv

## psql_db: create PostgreSQL penguins database
.PHONY: psql_db
psql_db: bin/create_penguins_psql.py
	python $< penguins misc/penguins.csv

## release: create a release
.PHONY: release
release:
	@rm -rf sql-tutorial.zip
	@zip -r sql-tutorial.zip \
	db \
	misc/penguins.csv \
	src \
	-x \*~
