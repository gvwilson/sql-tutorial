## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## all: make all required files
.PHONY: all
all : data/assays.db data/penguins.db

## data/assays.db: create SQLite database of synthetic experimental data
data/assays.db: bin/create_assays_db.py
	python $< $@

## data/penguins.db: create single-table SQLite database of penguin data
data/penguins.db : bin/create_penguins_db.sql data/penguins.csv
	sqlite3 $@ < $<

## clean: clean up stray files
.PHONY: clean
clean:
	@rm -f *~
