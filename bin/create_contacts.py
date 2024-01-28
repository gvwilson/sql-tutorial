from faker import Faker
import graphviz
import random
import sqlite3
import sys

LOCALE = "es_MX"
NUM_GROUPS = 3
NUM_PER_GROUP = 5
SEED = 9181237

CREATE_TABLE = """\
    drop table if exists person;
    create table person (
        ident integer primary key autoincrement,
        name text not null
    );
    drop table if exists contact;
    create table contact (
        left text not null,
        right text not null
    );
"""


def main():
    """Main driver."""
    filename = sys.argv[1]
    graphname = sys.argv[2]

    random.seed(SEED)
    f = Faker(LOCALE)

    connection = sqlite3.connect(filename)
    connection.executescript(CREATE_TABLE)

    dot = graphviz.Graph("connections")

    for _ in range(NUM_GROUPS):
        people = [f"{f.first_name()} {f.last_name()}" for _ in range(NUM_PER_GROUP)]
        for name in people:
            dot.node(name, fontsize="10.0")

        pairs = [
            list(sorted([people[i], people[j]]))
            for i in range(len(people))
            for j in range(i + 1, len(people))
        ]
        num_connections = random.randint(1, NUM_PER_GROUP - 1)
        pairs = random.sample(pairs, k=num_connections)

        connection.executemany("insert into person values (null, ?);", [[x] for x in people])
        connection.executemany("insert into contact values (?, ?);", pairs)
        connection.commit()

    for left, right in connection.execute("select * from contact;").fetchall():
        dot.edge(left, right)
    dot.render(format="svg", outfile=graphname, engine="fdp", cleanup=True)


if __name__ == "__main__":
    main()
