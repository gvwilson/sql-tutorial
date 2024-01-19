RUN_JUPYTER := PYDEVD_DISABLE_FILE_VALIDATION=1 jupyter nbconvert --execute
CSS_FILE := "tutorial.css"

NB_IPYNB := $(wildcard *.ipynb)
NB_HTML := $(patsubst %.ipynb,%.html,${NB_IPYNB})

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

## rerun: re-run all notebooks
.PHONY: rerun
rerun:
	@for nb in ${NB_IPYNB}; do ${RUN_JUPYTER} --to notebook --inplace $${nb}; done

## html: re-create HTML versions of notebooks
.PHONY: html
html: ${NB_HTML}
%.html: %.ipynb
	@${RUN_JUPYTER} --to html $<

## clean: clean up stray files
.PHONY: clean
clean:
	@rm -f *~
