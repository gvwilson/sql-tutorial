include lib/mccole/mccole.mk

## databases: make required files
.PHONY: databases
databases : \
	${DB}/assays.db \
	${DB}/contact_tracing.db \
	${DB}/lab_log.db \
	${DB}/penguins.db \
	misc/penguins.csv
	
	python bin/create_penguins_psql.py penguins misc/penguins.csv


${DB}/assays.db: bin/create_assays_db.py
	python $< $@

${DB}/contact_tracing.db: bin/create_contacts.py
	python $< $@

${DB}/lab_log.db: bin/create_lab_log.py
	python $< $@

${DB}/penguins.db : bin/create_penguins.py misc/penguins.csv
	python $< $@ misc/penguins.csv

## Alternative way to create psql database. If we uncomment this, we can delete line 12.
## misc/penguins.csv: bin/create_penguins_psql.py
##	 python $< penguins $@


## release: create a release
.PHONY: release
release:
	@rm -rf sql-tutorial.zip
	@zip -r sql-tutorial.zip \
	db \
	misc/penguins.csv \
	src \
	-x \*~
