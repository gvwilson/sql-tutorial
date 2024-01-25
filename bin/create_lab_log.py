"""Generate JSON records of lab operations."""

import json
import random
import sqlite3
import sys
from faker import Faker


CREATE_TABLES = """\
drop table if exists person;
create table person(
       ident            integer primary key autoincrement,
       details          text not null
);

drop table if exists machine;
create table machine(
       ident            integer primary key autoincrement,
       name             text not null,
       details          text not null
);

drop table if exists usage;
create table usage(
       ident            integer primary key autoincrement,
       log              text not null
);
"""

MACHINES = {
    "WY401": {"acquired": "2023-05-01"},
    "Inphormex": {"acquired": "2021-07-15", "refurbished": "2023-10-22"},
    "AutoPlate 9000": {"note": "needs software update"},
}

TRANSITIONS = {
    "WY401": {"Inphormex": 50, "sterilizer": 50},
    "Inphormex": {"WY401": 25, "Inphormex": 25, "AutoPlate 9000": 25, None: 25},
    "AutoPlate 9000": {"Inphormex": 25, "sterilizer": 50, None: 25},
    "sterilizer": {"Inphormex": 30, "AutoPlate 9000": 30, None: 40},
}

PARAMS = {
    "frac_known": 0.9,
    "frac_phd": 0.25,
    "locale": "fr_CA",
    "max_involved": 3,
    "num_logs": 8,
    "num_persons": 8,
    "seed": 571298,
}

def main():
    """Main driver."""
    filename = sys.argv[1]
    random.seed(PARAMS["seed"])
    check_hardware()
    persons = create_persons()
    usages = [create_usage(persons) for _ in range(PARAMS["num_logs"])]
    save(filename, persons, usages)


def check_hardware():
    """Check consistency of hardware tables."""
    tx_keys = set(TRANSITIONS.keys())
    assert tx_keys.issuperset(MACHINES.keys())
    for (key, value) in TRANSITIONS.items():
        out = set(value.keys()) - {None}
        assert tx_keys.issuperset(out)
        assert sum(value.values()) == 100


def create_persons():
    """Make some people."""
    fake = Faker(PARAMS["locale"])
    data = [
        {"personal": fake.first_name(), "family": fake.last_name()}
        for i in range(PARAMS["num_persons"])
    ]
    for record in random.sample(data, int(PARAMS["num_persons"] * PARAMS["frac_phd"])):
        record["title"] = "Dr"
    return data


def create_usage(persons):
    """Generate random lab usage sequence."""
    involved = random.sample(persons, k=random.randint(1, PARAMS["max_involved"]))
    states = list(TRANSITIONS.keys())
    usage = []
    current = random.choice(states)
    while current is not None:
        person = random.sample(involved, k=1)[0]
        usage.append({"machine": current})
        if random.uniform(0.0, 1.0) < PARAMS["frac_known"]:
            usage[-1]["person"] = [person["personal"], person["family"]]
        next_states = list(TRANSITIONS[current].keys())
        next_weights = list(TRANSITIONS[current].values())
        current = random.sample(next_states, k=1, counts=next_weights)[0]
    return usage


def save(filename, persons, usages):
    """Save in database."""
    conn = sqlite3.connect(filename)
    conn.executescript(CREATE_TABLES)
    conn.executemany(
        "insert into person values (null, ?)",
        [[json.dumps(p)] for p in persons]
    )
    conn.executemany(
        "insert into machine values (null, ?, ?)",
        [[name, json.dumps(details)] for name, details in MACHINES.items()]
    )
    conn.executemany(
        "insert into usage values (null, ?)",
        [[json.dumps(usage)] for usage in usages]
    )
    conn.commit()


if __name__ == "__main__":
    main()
