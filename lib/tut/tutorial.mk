DOCS := docs
OUT := out
PAGES := pages
SRC := src
TEMPLATE := lib/tut

## --- : ---

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## build: rebuild website
.PHONY: build
build:
	@ark build
	@python ${TEMPLATE}/bin/copyfiles.py ${DOCS} "$$(python config.py copydir)" "$$(python config.py copyext)"

## serve: rebuild and serve website
.PHONY: serve
serve:
	@ark serve

## ordered: get all inclusions in order
.PHONY: ordered
ordered:
	@python ${TEMPLATE}/bin/ordered.py < ${PAGES}/index.md

## style: check Python code style
.PHONY: style
style:
	@ruff check .

## reformat: reformat unstylish Python code
.PHONY: reformat
reformat:
	@ruff format .

## clean: clean up stray files
.PHONY: clean
clean:
	@find . -name '*~' -exec rm {} \;
	@find . -name '*.bkp' -exec rm {} \;
	@find . -name '.*.dtmp' -exec rm {} \;
	@find . -type d -name __pycache__ | xargs rm -r
