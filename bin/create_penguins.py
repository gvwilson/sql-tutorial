"""Create penguins database including randomized little penguins."""

import csv
import random
import sqlite3
import sys

SEED = 571289354
LITTLE_SIZE = 10

CREATE = """\
drop table if exists penguins;
create table penguins (
    species text,
    island text,
    bill_length_mm real,
    bill_depth_mm real,
    flipper_length_mm real,
    body_mass_g real,
    sex text
);

drop table if exists little_penguins;
create table little_penguins (
    species text,
    island text,
    bill_length_mm real,
    bill_depth_mm real,
    flipper_length_mm real,
    body_mass_g real,
    sex text
);
"""


def _float(x):
    return None if x == "" else float(x)


def _text(x):
    return None if x == "" else x


FIELDS = [_text, _text, _float, _float, _float, _float, _text]


def main():
    """Main driver."""
    db_name = sys.argv[1]
    csv_name = sys.argv[2]

    conn = sqlite3.connect(db_name)
    conn.executescript(CREATE)

    reader = csv.reader(open(csv_name, "r"))
    rows = []
    for i, row in enumerate(reader):
        assert len(row) == len(FIELDS)
        if i == 0:
            continue
        rows.append([f(val) for f, val in zip(FIELDS, row)])

    spots = ", ".join("?" * len(FIELDS))
    conn.executemany(f"insert into penguins values ({spots});", rows)

    random.seed(SEED)
    rows = random.sample(rows, LITTLE_SIZE)
    conn.executemany(f"insert into little_penguins values ({spots});", rows)

    conn.commit()


if __name__ == "__main__":
    main()
