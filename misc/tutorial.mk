SRC := src
OUT := out
PAGE := index.md

## --- : ---

## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## build: rebuild website
.PHONY: build
build:
	@jekyll build

## serve: rebuild and serve website
.PHONY: serve
serve:
	@jekyll serve

## template: package template
.PHONY: template
template:
	zip -r /tmp/tutorial-template.zip \
	CODE_OF_CONDUCT.md \
	LICENSE.md \
	_config.yml \
	_includes \
	_layouts \
	bin/ordered.py \
	bin/renumber_headings.py \
	bin/lint.py \
	colophon.md \
	conduct_.md \
	contributing_.md \
	favicon.ico \
	license_.md \
	misc/tutorial.mk \
	res \
	-x \*~

## ordered: get all inclusions in order
.PHONY: ordered
ordered:
	@python bin/ordered.py < index.md

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
	@rm -f *~
	@rm -rf _site
