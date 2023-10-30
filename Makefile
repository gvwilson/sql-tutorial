# By default, show available commands
.DEFAULT: commands

# Tables
TABLES := machines scientists experiments performed used notes

# All CSV files used to make database
CSV := $(patsubst %,data/%.csv,${TABLES})

# Database file
DB := ./lab.db

# SQLite executable
SQLITE := sqlite3

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## db: rebuild laboratory database
db: ${DB}

${DB}: scripts/make-db.sql ${CSV}
	${SQLITE} $@ < $<

## clean: tidy up
.PHONY: clean
clean:
	@find . -name '*~' -exec rm {} \;
	@rm -f ${DB}
