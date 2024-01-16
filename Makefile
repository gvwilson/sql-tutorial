## commands: show available commands
.PHONY: commands
commands:
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'

## all: make all required files
.PHONY: all
all : penguins.db

## penguins.db: create SQLite database from penguins data
penguins.db : create-penguins.sql penguins.csv
	sqlite3 $@ < $<

## clean: clean up stray files
.PHONY: clean
clean:
	@rm -f *~
