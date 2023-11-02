# By default, show available commands
.DEFAULT: commands

# Tools
JEKYLL := jekyll
SQLITE := sqlite3

# Script to regenerate output files
RERUN := scripts/rerun.py

# Database file
DB := ./lab.db

# Directories.
CSV_DIR := data
SRC_DIR := src
OUT_DIR := _md

# Tables
TABLES := machines scientists experiments performed used

# All CSV files used to make database
CSV := $(patsubst %,${CSV_DIR}/%.csv,${TABLES})

# All SQL examples.
SRC := $(wildcard ${SRC_DIR}/*.sql)

# Generated output.
MARKDOWN := $(patsubst ${SRC_DIR}/%.sql,${OUT_DIR}/%.md,${SRC})

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

## markdown: regenerate Markdown from SQL
.PHONY: markdown
markdown: ${MARKDOWN}

${OUT_DIR}/%.md: ${SRC_DIR}/%.sql ${DB} ${RERUN}
	@mkdir -p ${OUT_DIR}
	python ${RERUN} --dbfile ${DB} --infile $< --outfile $@

## build: rebuild the site
.PHONY: build
build: ${MARKDOWN}
	${JEKYLL} build

## serve: rebuild and serve the site
.PHONY: serve
serve: ${MARKDOWN}
	${JEKYLL} serve

## clean: tidy up
.PHONY: clean
clean:
	@find . -name '*~' -exec rm {} \;
	@rm -f ${DB}

## sterile: really tidy up
.PHONY: sterile
sterile: clean
	@rm -rf ${OUT_DIR}

## settings: show variables
.PHONY: settings
settings:
	@echo "SQLITE" ${SQLITE}
	@echo "RERUN" ${RERUN}
	@echo "DB" ${DB}
	@echo "CSV_DIR" ${CSV_DIR}
	@echo "SRC_DIR" ${SRC_DIR}
	@echo "OUT_DIR" ${OUT_DIR}
	@echo "TABLES" ${TABLES}
	@echo "CSV" ${CSV}
	@echo "SRC" ${SRC}
	@echo "MARKDOWN" ${MARKDOWN}
