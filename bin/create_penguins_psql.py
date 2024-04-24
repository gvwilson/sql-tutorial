import psycopg2
import sys

def main(dbname, csv_file_path):
    conn_string     = f"dbname=postgres"
    conn            = psycopg2.connect(conn_string)
    conn.autocommit = True
    cur             = conn.cursor()
    role_name       = "penguin_reader_writer"

    try:
        # To start from scratch we need to cleanup both the role and the database
        cur.execute(f"DROP DATABASE IF EXISTS {dbname};") # database
        cur.execute(f"DROP ROLE IF EXISTS {role_name};")  # role


        cur.execute(f"CREATE DATABASE {dbname};")
    except Exception as e:
        print(f"Error creating database: {e}")
        sys.exit(1)
    finally:
        cur.close()
        conn.close()

    # Connect to the new database to create tables and import data
    conn_string     = f"dbname={dbname}"
    conn            = psycopg2.connect(conn_string)
    conn.autocommit = True
    cur             = conn.cursor()

    try:
        # First we create the table `penguins` (just column definitions, no data)
        cur.execute("""
            CREATE TABLE penguins (
                species text,
                island text,
                bill_length_mm real,
                bill_depth_mm real,
                flipper_length_mm real,
                body_mass_g real,
                sex text
            );
        """)

        # Import data from CSV into the database
        with open(csv_file_path, 'r') as f:
            cur.copy_expert(f"COPY penguins FROM STDIN WITH CSV HEADER DELIMITER ','", f)
    except Exception as e:
        print(f"Error in database setup: {e}")
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
