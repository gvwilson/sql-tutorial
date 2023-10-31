# By default, show available commands
.DEFAULT: commands

# SQLite executable
SQLITE := sqlite3

# Database file
DB := ./lab.db

# Directories.
CSV_DIR := data
SRC_DIR := .
OUT_DIR := _out

# Tables
TABLES := machines scientists experiments performed used notes

# All CSV files used to make database
CSV := $(patsubst %,${CSV_DIR}/%.csv,${TABLES})

# All SQL examples.
SRC := $(wildcard ${SRC_DIR}/*.sql)

# Generated output.
OUTPUT := $(patsubst %.sql,${OUT_DIR}/%.txt,${SRC})

# ----------------------------------------------------------------------

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## db: rebuild laboratory database
.PHONY: db
db: ${DB}

${DB}: scripts/make-db.sql ${CSV}
	${SQLITE} $@ < $<

## examples: re-run out-of-date examples
.PHONY: examples
examples: ${OUTPUT}

${OUT_DIR}/%.txt: %.sql ${DB}
	@mkdir -p ${OUT_DIR}
	${SQLITE} ${DB} < $< > $@

## clean: tidy up
.PHONY: clean
clean:
	@find . -name '*~' -exec rm {} \;
	@rm -f ${DB}

## sterile: really tidy up
.PHONY: sterile
sterile: clean
	@rm -rf ${OUT_DIR}
