"""Create a database with synthetic experimental data."""

import argparse
from datetime import date, datetime, timedelta
from pathlib import Path
import random
import sqlite3
import string
import sys

from faker import Faker

CREATE_TABLES = """\
drop table if exists department;
create table department(
       ident            text not null,
       name             text not null,
       building         text not null
);

drop table if exists staff;
create table staff(
       ident            integer primary key autoincrement,
       personal         text not null,
       family           text not null,
       dept             text
);

drop table if exists experiment;
create table experiment(
       ident            integer primary key autoincrement,
       kind             text not null,
       started          text not null,
       ended            text
);

drop table if exists performed;
create table performed(
       staff            integer not null,
       experiment       integer not null,
       foreign key (staff) references staff(ident),
       foreign key (experiment) references experiment(ident)
);

drop table if exists plate;
create table plate(
       ident            integer primary key autoincrement,
       experiment       integer not null,
       upload_date      text not null,
       filename         text unique
);

drop table if exists invalidated;
create table invalidated(
       plate            integer not null,
       staff            integer not null,
       invalidate_date  text not null
);
"""

DEPARTMENTS = [
    {"ident": "gen", "name": "Genetics", "building": "Chesson"},
    {"ident": "hist", "name": "Histology", "building": "Fashet Extension"},
    {"ident": "mb", "name": "Molecular Biology", "building": "Chesson"},
]

PARAMS = {
    "enddate": date(2023, 11, 10),
    "experiments": 50,
    "filename_len": 8,
    "invalid": 0.1,
    "locale": "en_IN",
    "seed": 21894712,
    "staff": 10,
    "startdate": date(2023, 11, 1),
    "treated": 8.0,
}

EXPERIMENTS = {
    "calibration": {"staff": [1, 1], "duration": [0, 0], "plates": [1, 1]},
    "trial": {"staff": [1, 2], "duration": [1, 2], "plates": [2, 16]},
}


def main():
    """Main driver."""
    filename = sys.argv[1]
    random.seed(PARAMS["seed"])
    sqlite_configure()
    fake = Faker(PARAMS["locale"])
    connection = create_tables(filename)
    fill_staff(connection, fake)
    fill_experiments(connection, fake)
    connection.commit()


def create_tables(filename):
    """Create database tables."""
    connection = sqlite3.connect(filename)
    connection.executescript(CREATE_TABLES)
    return connection


def date_to_timestamp(d):
    """Convert a date to a timestamp."""
    return datetime(d.year, d.month, d.day).timestamp()


def fill_experiments(connection, fake):
    """Create experiments and their data."""
    kinds = list(EXPERIMENTS.keys())
    staff_ids = list(range(1, PARAMS["staff"] + 1))
    experiments = []
    performed = []
    plates = []

    random_filename = make_random_filename()
    for experiment_id in range(1, PARAMS["experiments"] + 1):
        kind = random.choice(kinds)

        started, ended = random_experiment_duration(kind)
        experiments.append(
            (experiment_id, kind, round_date(started), round_date(ended))
        )

        num_staff = random.randint(*EXPERIMENTS[kind]["staff"])
        performed.extend(
            [(s, experiment_id) for s in random.sample(staff_ids, num_staff)]
        )

        if ended is not None:
            plates.extend(
                random_plates(kind, experiment_id, started, random_filename)
            )

    invalidated = invalidate_plates(plates)

    connection.executemany(
        "insert into department values (?, ?, ?)",
        [(d["ident"], d["name"], d["building"]) for d in DEPARTMENTS]
    )
    connection.executemany("insert into experiment values (?, ?, ?, ?)", experiments)
    connection.executemany("insert into performed values (?, ?)", performed)
    connection.executemany("insert into plate values (null, ?, ?, ?)", plates)
    connection.executemany("insert into invalidated values (?, ?, ?)", invalidated)


def fill_staff(connection, fake):
    """Create people."""
    data = [(fake.first_name(), fake.last_name(), random_department(i)) for i in range(PARAMS["staff"])]
    connection.executemany("insert into staff values (null, ?, ?, ?)", data)


def invalidate_plates(plates):
    """Invalidate a random set of plates."""
    selected = [
        (i, p[1]) for (i, p) in enumerate(plates) if random.random() < PARAMS["invalid"]
    ]
    return [
        (
            plate_id,
            random.randint(1, PARAMS["staff"] + 1),
            random_date_interval(upload_date, PARAMS["enddate"]),
        )
        for (plate_id, upload_date) in selected
    ]


def make_random_filename():
    """Create a random filename generator."""
    filenames = set([""])
    result = ""
    while True:
        while result in filenames:
            stem = "".join(random.choices(string.hexdigits, k=PARAMS["filename_len"])).lower()
            result = f"{stem}.csv"
        filenames.add(result)
        yield result


def random_department(which):
    """Choose a department at random."""
    if which == 0:
        return None # ensure at least one with missing department
    return random.choice([None, *[d["ident"] for d in DEPARTMENTS]])


def random_experiment_duration(kind):
    """Choose random start date and end date for experiment."""
    start_stamp = date_to_timestamp(PARAMS["startdate"])
    end_stamp = date_to_timestamp(PARAMS["enddate"])
    start = datetime.fromtimestamp(random.uniform(start_stamp, end_stamp))
    duration = timedelta(days=random.randint(*EXPERIMENTS[kind]["duration"]))
    end = start + duration
    end = None if end > datetime.fromtimestamp(end_stamp) else end
    return start, end


def random_plates(kind, experiment_id, start_date, random_filename):
    """Generate random plate data."""
    return [
        (
            experiment_id,
            random_date_interval(start_date, PARAMS["enddate"]),
            next(random_filename),
        )
        for _ in range(random.randint(*EXPERIMENTS[kind]["plates"]))
    ]


def random_date_interval(start_date, end_date):
    """Choose a random end date (inclusive)."""
    if isinstance(start_date, date):
        start_date = datetime(*start_date.timetuple()[:3])
    choice = random.uniform(date_to_timestamp(start_date), date_to_timestamp(end_date))
    choice = datetime.fromtimestamp(choice)
    return round_date(choice)


def round_date(raw):
    """Round time to whole day."""
    return None if raw is None else date(*raw.timetuple()[:3])


def sqlite_configure():
    """Configure sqlite adapters and converters."""
    def _adapt_date_iso(val):
        return val.isoformat()
    sqlite3.register_adapter(date, _adapt_date_iso)

    def _convert_date(val):
        return date.fromisoformat(val.decode())
    sqlite3.register_converter("date", _convert_date)


if __name__ == "__main__":
    main()
