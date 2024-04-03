---
title: "PostgreSQL"
tagline: "Client-server computing and permissions"
---

*Contributed by [Konstantinos Kitsios][kitsios_konstantinos].*

## Why PostgreSQL?

-   This is a valid question, especially if you are already familiar with other databases like SQLite
    that are simpler to set up,
    run locally,
    and do not follow the [client-server model](#what-is-the-client-server-model-after-all).
-   The answer is that the client-server model that PostgreSQL follows offers robustness,
    scalability,
    and effectiveness in handling large volumes of data.
-   Furthermore, it provides enhanced concurrency with features like multi-line transactions.
    The above are necessary for modern, complex, real-world applications,
    and non-client-server databases like SQLite cannot guarantee them.

## The Client-Server Model

-   A [%g local_db "local (non-client-server) database" %]
    is designed to run on a single computer or device,
    storing data locally and accessed by applications on the same machine.
-   This setup is ideal for standalone applications where simplicity and ease of deployment are priorities.
-   On the other hand, a [%g client_server_db "client-server database" %]
    operates on a networked environment where the database server runs independently of client applications.
-   Clients connect to the server over a network to query, update, and manage data.
    -   Of course the server and the client can live on the same machine.
    -   Mainly done for educational purposes (like this tutorial).

## Setup on MacOS: Direct Installer

1.  Download the [latest version of PostgreSQL for macOS][postgresql_macos_latest].
2.  Double-click the downloaded file to run the installer
    1.  Click "Next".
        You might see a warning message because it was downloaded from the internet.
        If so, click "Open" to continue.
    2.  Leave the default installation folder and click "Next".
    3.  Leave the default components and click "Next".
    4.  Leave the default location (the database files will be stored there). 
    5.  You will be prompted to create a password; make sure to remember it. Click "Next".
    6.  Leave the default options (port and locale) and click "Next".
    7.  Click "Next"; if requested, provide your Mac OS password (the one you use for unlocking your laptop).
    8.  Click "Finish".
3.  Open PgAdmin from the Applications folder.
4.  In the top-left corner of PgAdmin, expand the "Servers" option by clicking on it.
5.  Click "PostgreSQL"; if prompted, use the password you created in step 2.4.
6.  You are now connected to PostgreSQL.

## Setup on MacOS: With Options

1.  Download [the latest version of Postgress.app][postgresql_macos_app].
2.  Open the downloaded `.dmg` file.
3.  Drag `Postgres` to the Applications folder.
4.  Open the Applications folder, then open `Postgres`.
    The first time you open the app,
    you might see a warning message because it was downloaded from the internet.
    If so, click "Open" to continue.
5.  Once the app is open, click "Initialize" to start your PostgreSQL session.
6.  You can see the existing databases (they have been created by default).
    Double click one and the terminal for running queries to that database will open
7.  You are now connected to PostgreSQL.

## Setup on MacOS: Command-Line Tools {: .aside}

1.  Open a terminal window.
2.  Run `open ~/.zshrc` (or `~/.bashrc` depending on your shell).
3.  Add the following line to the bottom of the file:
    <br>
    `export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin`
4.  Run `source ~/.zshrc`.
5.  Verify installation by running `psql`.

## Running Queries Using PgAdmin

-   Open PgAdmin.

-   Right click "Databases" -> "Create" -> "Database".
    Write "penguins" in the "Database" field and then click "Save".

-  Right click to the "penguins" database from the menu in the left:
    a. Click "Query tool".
    b. Click "Open file" in the top left of the Query tool.
    c. Select the file `db/penguins.sql`.
    d. Click "Execute".

-   Expand "penguins" -> "Schemas" -> "Tables".
    You should see two tables: `little_penguins` and `penguins`.

-   Right click `penguins` -> "Query tool".

-   Run the query to see the first entries of the `penguins` table.

[%inc select_penguins.sql %]

-   Count penguins:

[%inc count_penguins.sql %]

## Running Queries in the Terminal

-   Run the command-line PostgreSQL client and tell it what database to use:

[%inc run_psql_penguins.sh %]

-   Run the queries from the previous section

## Privileges and Roles

-   PostgreSQL is commonly used for applications with a large user base.
-   For this reason, it has a [%g privilege "privilege managment system" %]
    to control who has what kind of access to what data.
    -   You may want the users of your application to be able to read the SQL records,
        but not update or delete them.
    -   Or in an organization where many developers work on the same database,
        it may be desirable that some developer teams can only read existing or write new records,
	but not modify or delete existing records.

## Creating a Role and Granting Privileges

-   A database [%g role "role" %] is similar to a user account
    -   Can own database objects
    -   Can be granted permissions to access and manipulate data

-   Roles can represent individual users, groups of users, or both.

-   Can be assigned a variety of privileges and access rights within the database

-   Create role in PgAdmin:
    1.  In the Object Explorer panel,
        expand Servers -> PostgreSQL -> Right click Login/Group roles -> Create -> Login/Group role.
    2.  Enter "penguin_reader_writer" in the "name" field.
    3.  Go to the "Privileges" tab, and enable the "Can Login?" option.
    4.  Click "Save".

-   Grant permissions in PgAdmin:
    1.  Right click the "penguins" table from Object Explorer.
    2.  Go to "Properties" -> "Security" -> Click the "+" button on the top-right.
    3.  Select "penguin_reader_writer" from the dropdown list.
    4.  In the "Privileges" column, check the "SELECT" and "UPDATE" options.
    5.  Click "Save".

-   Create role in the terminal:

[%inc create_reader_writer.sql %]

-   Grant permissions in the terminal:

[%inc grant_select_update.sql %]

## Verifying Privileges in PgAdmin

-   Connect as `penguin_reader_writer` to verify that this role can only select or update records:
    1.  Right click "Servers" -> "Register" -> "Server" in the left panel.
    2.  In the "name" field enter "Penguin Reader Writer".
    3.  Go to the "Connection" tab:
        a.  In the "Host name/address" field enter "localhost".
        b.  In the "Maintenance database" field enter "penguins".
        c.  In the "Username" field enter "penguin_reader_writer".
        d.  In the "Password" field enter "reader_writer".
    4.  Click "Save".

-   Close and reopen PgAdmin,
    but instead of "PostgreSQL", select the "Penguin Reader Writer" as the user ID.
-   Run a simple query that *reads* data:

[%inc select_penguins.sql %]

-   It successfully returns 10 records from the table.

-   Now try to *change* data:

[%inc update_penguins.sql %]

-   That works too (updates 23 records).

-   But now try to *delete* data:

[%inc delete_penguins.sql %]
[%inc delete_penguins.out %]

-   Because the `penguin_reader_writer` role does not have `DELETE` privileges

## Revoking Privileges

-   Tighten up access so that `penguin_reader_writer` does not have `UPDATE` privileges (only `SELECT`)
-   In PgAdmin:
    1.  Right click on the "penguins" table in the Object Explorer panel.
    2.  Go to "Properties" -> "Security" -> Click the "Privileges" column of the `penguin_reader_writer` row.
    3.  Un-check the "Update" checkbox.
    4.  Click "Save".
-   In the terminal:

[%inc revoke_update.sql %]

-   To verify:

[%inc update_penguins_again.sql %]
[%inc update_penguins_again.out %]
