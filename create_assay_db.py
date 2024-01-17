"""Generate assay database."""

import argparse
from datetime import date, datetime, timedelta
from pathlib import Path
import random
import sqlite3
import string

from faker import Faker

from assay_params import load_params

EXPERIMENTS = {
    "calibration": {"staff": [1, 1], "duration": [0, 0], "plates": [1, 1]},
    "trial": {"staff": [1, 2], "duration": [1, 2], "plates": [2, 16]},
}
FILENAME_LENGTH = 8


def main():
    """Main driver."""
    args = parse_args()
    params = load_params(args.params)
    random.seed(params.seed)
    fake = Faker(params.locale)

    connection = create_tables(args)
    fill_staff(params, connection, fake)
    fill_experiments(params, connection, fake)
    connection.commit()


def create_tables(args):
    """Create database tables."""
    sql = Path(args.tables).read_text()
    connection = sqlite3.connect(args.dbfile)
    connection.executescript(sql)
    return connection


def fill_experiments(params, connection, fake):
    """Create experiments and their data."""
    kinds = list(EXPERIMENTS.keys())
    staff_ids = list(range(1, params.staff + 1))
    experiments = []
    performed = []
    plates = []

    random_filename = make_random_filename()
    for experiment_id in range(1, params.experiments + 1):
        kind = random.choice(kinds)

        started, ended = random_experiment_duration(params, kind)
        experiments.append(
            (experiment_id, kind, round_date(started), round_date(ended))
        )

        num_staff = random.randint(*EXPERIMENTS[kind]["staff"])
        performed.extend(
            [(s, experiment_id) for s in random.sample(staff_ids, num_staff)]
        )

        if ended is not None:
            plates.extend(
                random_plates(params, kind, experiment_id, started, random_filename)
            )

    invalidated = invalidate_plates(params, plates)

    connection.executemany("insert into experiment values (?, ?, ?, ?)", experiments)
    connection.executemany("insert into performed values (?, ?)", performed)
    connection.executemany("insert into plate values (null, ?, ?, ?)", plates)
    connection.executemany("insert into invalidated values (?, ?, ?)", invalidated)


def fill_staff(params, connection, fake):
    """Create people."""
    data = [(fake.first_name(), fake.last_name()) for _ in range(params.staff)]
    connection.executemany("insert into staff values (null, ?, ?)", data)


def invalidate_plates(params, plates):
    """Invalidate a random set of plates."""
    selected = [
        (i, p[1]) for (i, p) in enumerate(plates) if random.random() < params.invalid
    ]
    return [
        (
            plate_id,
            random.randint(1, params.staff + 1),
            random_date_interval(upload_date, params.enddate),
        )
        for (plate_id, upload_date) in selected
    ]


def make_random_filename():
    """Create a random filename generator."""
    filenames = set([""])
    result = ""
    while True:
        while result in filenames:
            stem = "".join(random.choices(string.hexdigits, k=FILENAME_LENGTH)).lower()
            result = f"{stem}.csv"
        filenames.add(result)
        yield result


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--dbfile", type=str, required=True, help="database file")
    parser.add_argument("--params", type=str, required=True, help="parameter file")
    parser.add_argument("--tables", type=str, required=True, help="SQL tables file")
    return parser.parse_args()


def random_experiment_duration(params, kind):
    """Choose random start date and end date for experiment."""
    start = random.uniform(params.startdate.timestamp(), params.enddate.timestamp())
    start = datetime.fromtimestamp(start)
    duration = timedelta(days=random.randint(*EXPERIMENTS[kind]["duration"]))
    end = start + duration
    end = None if end > params.enddate else end
    return start, end


def random_plates(params, kind, experiment_id, start_date, random_filename):
    """Generate random plate data."""
    return [
        (
            experiment_id,
            random_date_interval(start_date, params.enddate),
            next(random_filename),
        )
        for _ in range(random.randint(*EXPERIMENTS[kind]["plates"]))
    ]


def random_date_interval(start_date, end_date):
    """Choose a random end date (inclusive)."""
    if isinstance(start_date, date):
        start_date = datetime(*start_date.timetuple()[:3])
    choice = random.uniform(start_date.timestamp(), end_date.timestamp())
    choice = datetime.fromtimestamp(choice)
    return round_date(choice)


def round_date(raw):
    """Round time to whole day."""
    return None if raw is None else date(*raw.timetuple()[:3])


if __name__ == "__main__":
    main()
