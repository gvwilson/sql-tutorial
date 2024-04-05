# ----------------------------------------------------------------------
# Generic McCole Makefile
# ----------------------------------------------------------------------

# By default, show available commands (by finding '##' comments)
.DEFAULT: commands

# Project root directory
ROOT := .

# Where to find tools
THEME_BIN := ${ROOT}/lib/mccole/bin

# Standard GitHub pages (in root directory rather than website source directory)
GITHUB_PAGES := ${ROOT}/CODE_OF_CONDUCT.md ${ROOT}/LICENSE.md

# All Markdown source pages
SRC_PAGES := $(wildcard ${ROOT}/src/*.md) $(wildcard ${ROOT}/src/*/index.md)

# Generated HTML pages
DOCS_PAGES := $(patsubst ${ROOT}/src/%.md,${ROOT}/docs/%.html,$(SRC_PAGES))

# Information files
INFO_GLOSSARY := ${ROOT}/info/glossary.yml
INFO_BIB := info/bibliography.bib
TMP_BIB := tmp/bibliography.html

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} \
	| sed -e 's/## //g' \
	| column -t -s ':'

## build: rebuild site without running server
.PHONY: build
build: ${TMP_BIB}
	ark build
	@touch ${ROOT}/docs/.nojekyll

## serve: build site and run server
.PHONY: serve
serve:
	ark watch

## profile: profile compilation
.PHONY: profile
profile:
	python ${THEME_BIN}/run_profile.py

## bib: rebuild HTML version of bibliography
bib: ${TMP_BIB} ${THEME_BIN}/make_bibliography.py
${TMP_BIB}: ${INFO_BIB}
	@mkdir -p ${ROOT}/tmp
	python ${THEME_BIN}/make_bibliography.py --infile $< --outfile $@

## lint: check project
.PHONY: lint
lint:
	@python ${THEME_BIN}/lint.py \
	--dom ${ROOT}/lib/mccole/dom.yml \
	--html ${DOCS_PAGES} \
	--root ${ROOT}
	@html5validator --root ${ROOT}/docs ${DOCS_PAGES} \
	--ignore \
	'Attribute "ix-key" not allowed on element "span"' \
	'Attribute "ix-ref" not allowed on element "a"' \
	'Attribute "markdown" not allowed on element "a"' \
	'Attribute "markdown" not allowed on element "span"'

## style: check Python code style
.PHONY: style
style:
	@ruff check .

## reformat: reformat unstylish Python code
.PHONY: reformat
reformat:
	@ruff format .

## pack: create a release
.PHONY: pack
pack:
	@rm -f mccole.zip
	zip -r mccole.zip \
	CODE_OF_CONDUCT.md \
	LICENSE.md \
	docs/.nojekyll \
	lib \
	src/bib \
	src/colophon \
	src/conduct \
	src/contents \
	src/contrib \
	src/glossary \
	src/license \
	-x '**/__pycache__/*' -x '*~'

## unpack: make required files after unzipping mccole.zip
.PHONY: unpack
unpack:
	mkdir -p info src
	touch \
	config.py \
	Makefile \
	CODE_OF_CONDUCT.md \
	CONTRIBUTING.md \
	LICENSE.md \
	README.md \
	requirements.txt \
	info/bibliography.bib \
	info/glossary.yml \
	info/links.yml \
	info/thanks.yml \
	src/index.md

## clean: clean up stray files
.PHONY: clean
clean:
	@find ${ROOT} -name '*~' -exec rm {} \;
	@find ${ROOT} -name '*.bkp' -exec rm {} \;
	@find ${ROOT} -name '.*.dtmp' -exec rm {} \;
	@find ${ROOT} -type d -name __pycache__ | xargs rm -r
	@find ${ROOT} -type d -name .pytest_cache | xargs rm -r
