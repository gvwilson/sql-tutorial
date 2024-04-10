include ../../examples.mk

SRC := $(wildcard *.py)
OUT := $(patsubst %.py,%.out,${SRC})

.PHONY: all
all: ${OUT}

basic_python_query.out: basic_python_query.py
	python $< ${DB}/penguins.db > $@

incremental_fetch.out: incremental_fetch.py
	python $< ${DB}/penguins.db > $@

orm.out: orm.py
	python $< ${DB}/assays.db > $@

orm_relation.out: orm_relation.py
	python $< ${DB}/assays.db > $@

select_pandas.out: select_pandas.py
	python $< ${DB}/penguins.db > $@

select_polars.out: select_polars.py
	python $< ${DB}/penguins.db > $@

%.out: %.py
	python $< > $@

.PHONY: settings
settings: root_settings
