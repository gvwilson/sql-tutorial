# Common Make definitions for examples

SQLITE := sqlite3

# Get the path to this file from wherever it is included.
# See https://stackoverflow.com/questions/18136918/how-to-get-current-relative-directory-of-your-makefile
ROOT := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))

MODE := ${ROOT}/misc/mode.txt
MEMORY := ${SQLITE} :memory:

DB := ${ROOT}/db
ASSAYS := ${SQLITE} ${DB}/assays.db
CONTACTS := ${SQLITE} ${DB}/contact_tracing.db
LAB_LOG := ${SQLITE} ${DB}/lab_log.db
PENGUINS := ${SQLITE} ${DB}/penguins.db

ASSAYS_TMP := ${SQLITE} /tmp/assays.db
CONTACTS_TMP := ${SQLITE} /tmp/contact_tracing.db
PENGUINS_TMP := ${SQLITE} /tmp/penguins.db

%.assays.out: %.assays.sql
	cat ${MODE} $< | ${ASSAYS} > $@

%.contacts.out: %.contacts.sql
	cat ${MODE} $< | ${CONTACTS} > $@

%.lab_log.out: %.lab_log.sql
	cat ${MODE} $< | ${LAB_LOG} > $@

%.memory.out: %.memory.sql
	cat ${MODE} $< | ${MEMORY} > $@

%.penguins.out: %.penguins.sql
	cat ${MODE} $< | ${PENGUINS} > $@

.PHONY: root_settings
root_settings:
	@echo "DB" ${DB}
	@echo "MEMORY" ${MEMORY}
	@echo "MODE" ${MODE}
	@echo "OUT" ${OUT}
	@echo "PENGUINS" ${PENGUINS}
	@echo "ROOT" ${ROOT}
	@echo "SQLITE" ${SQLITE}
	@echo "SRC" ${SRC}
