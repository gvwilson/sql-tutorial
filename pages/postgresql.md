# Why PostgreSQL?
This is a valid question, especially if you are already familiar with other databases like `sqlite`, that are simpler to setup, run locally, and do not follow the [client-server model](#what-is-the-client-server-model-after-all) . The answer is that the client-server model that `postgresql` follows offers robustness, scalability, and effectiveness in handling large volumes of data. Furthermore, it provides enhanced concurrency with features like multi-line transactions. The above are necessary for modern, complex, real-world applications, and non-client-server databases (like `sqlite`) cannot guarantee them.

# What is the client-server model after all?
A **local** (non-client-server) database is designed to run on a single computer or device, storing data locally and accessed by applications on the same machine. This setup is ideal for standalone applications where simplicity and ease of deployment are priorities. On the other hand, a **client-server** database operates on a networked environment where the database server runs independently of client applications. Clients connect to the server over a network to query, update, and manage data. Of course, both the server and the client can live in the same machine, mainly for educational purposes, like in this tutorial.

# Setting up PostgreSQL on MacOS
We present two options to easily setup PostgreSQL on MacOS; the first one offers a very quick and simple setup, while the second one offers more flexibility and control over the configurations. Both will work fine for this tutorial.

###### Option 1 (Direct installer)
1. Download the latest version of PostgreSQL for macOS from [here](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
2. Double-click the downloaded file to run the installer
    1. Click "Next". You might see a warning message because it was downloaded from the internet. If so, click "Open" to continue
    2. Leave the default installation folder and click "Next"
    3. Leave the default components and click "Next"
    4. Leave the default location (the database files will be stored there). 
    5. You will be prompted to create a password; make sure to remember it. Click "Next"
    6. Leave the default options (port and locale) and click "Next"
    7. Click "Next"; if requested, provide your Mac OS password (the one you use for unlocking your laptop)
    8. Click "Finish"
3. Open *PgAdmin 4* from the *Applications* folder
4. In the top-left corner of *PgAdmin*, expand the "Servers" option by clicking on it
5. Click "PostgreSQL"; if prompted, use the password you created in step 2.4
6. You are now connected to PostgreSQL; stay tuned to learn what database *privilages* are and how to manage them

###### Option 2 (Postgres.app)
1. Download the latest version of Postgress.app from [here](https://postgresapp.com/downloads.html)
2. Open the downloaded `.dmg` file
3. Drag `Postgres` to the Applications folder
4. Open the Applications folder, then open `Postgres`. The first time you open the app, you might see a warning message because it was downloaded from the internet. If so, click "Open" to continue
5. Once the app is open, click "Initialize" to start your PostgreSQL session
6. You can see the existing databases (they have been created by default). Double click one and the terminal for running queries to that database will open
7. You are now connected to PostgreSQL; stay tuned to learn what database *privilages* are and how to manage them
8. Optional and advanced - only if you wish to use the command line tools as well:
    1. Open terminal
    2. Run `open ~/.zshrc` (or `~/.bashrc` depending on your terminal)
    3. Add the following line to the bottom of the file: `export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin`. Adjust the version number if necessary. Save the file.
    4. Run `source ~/.zshrc`
    5. Verify installation by running `psql`


# Running queries
Now that everything is set up, let's run some simple queries. There are two equivalent ways to run queries. The first one is from the PgAdmin user interface, and is only available if you followed "Option 1" in setup. The second way is from the terminal, and is available regardless of the setup option you followed.

###### From PgAdmin
1. Open PgAdmin, following the steps 3-6 of [installation](#option-1-direct-installer).

2. Right click "Databases" -> "Create" -> "Database" -> write "penguins" in the "Database" field -> "Save"

3. Right click to the "penguins" database from the menu in the left
    a. Click "Query tool"
    b. Click "Open file" in the top left of the Query tool
    c. Select the file `db/penguins.sql`
    d. Click "Execute" or press "F5"

4. Expand "penguins" -> "Schemas" -> "Tables". You should see two tables: `little_penguins` and `penguins`.

5. Right click `penguins` -> "Query tool"

6. Run the query 
```sql
SELECT * FROM penguins LIMIT 10;
```
 to see the first entries of the `penguins` table

7. Let's see how many penguins we have: 
```sql
SELECT COUNT(*) from penguins;
```

8. Let's see how many species we have: 
```sql
SELECT DISTINCT(species) FROM penguins;
```

9. Let's see how many male/female penguins we have: 
```sql
SELECT sex, COUNT(*) FROM penguins GROUP BY sex;
```

NOTE: in how much depth should I go in explaining simple queries? Should I link back to the sqlite tutorial instead?


###### From terminal
To start running queries from terminal, let's start by initializing a PostgreSQL client. In your terminal, run
```sh
psql -d penguins 
```

Run the queries 6-9 from the previous section.

# Privileges & Roles
PostgreSQL is commonly used for applications with a large user base. For this reason, it has a privilege managment system. For example, you may want the users of your application to be able to read the SQL records, but not update or delete them. Or, in an organization where many developers work on the same database, it may be desirable that some developer teams can only read existing or write new records, but not modify or delete existing records - maybe only the Database Administration (DBA) team can do that. Here, we will see how you can achieve the above.

### Creating a role and granting privileges
In PostgreSQL, a database **role** is similar to a user account, capable of owning database objects and being granted permissions to access and manipulate data. Roles can represent individual users, groups of users, or both, and can be assigned a variety of privileges and access rights within the database system.

Again, we will do it both using PgAdmin UI and terminal 

###### PgAdmin
Let's create a new role:
1. In the *Object Explorer* panel, expand Servers -> PostgreSQL -> Right click Login/Group roles -> Create -> Login/Group role.
2. Enter "penguin_reader_writer" in the *name* field.
3. Go to the "Privileges" tab, and enable the "Can Login?" option.
4. Click save.

and grant `SELECT` and `UPDATE` privilages to that role on the "penguins" table:
1. Right click the "penguins" table from *Object Explorer*.
2. Go to "Properties" -> "Security" -> Click the "+" button on the top-right.
3. Select "penguin_reader_writer" from the dropdown list.
4. In the "Privileges" column, check the "SELECT" and "UPDATE" options.
5. Click save


###### Terminal
Similarly from the terminal:
```sql
CREATE ROLE penguin_reader_writer WITH LOGIN PASSWORD 'reader_writer';
```


```sql
GRANT SELECT, UPDATE ON penguins, little_penguins TO penguin_reader_writer;
```

###### Verify privileges
Now let's connect as *penguin_reader_writer* to verify that this role can only select or update records:
1. Right click "Servers" -> "Register" -> "Server" in the left panel.
2. In the "name" field enter "Penguin Reader Writer"
3. Go to the "Connection" tab:
    a. In the "Host name/address" field enter "localhost"
    b. In the "Maintenance database" field enter "penguins"
    c. In the "Username" field enter "penguin_reader_writer"
    d. In the "Password" field enter "reader_writer"
4. Click "Save"
5. Open PgAdmin, following the steps 3-6 of [installation](#option-1-direct-installer), but instead of "PostgreSQL", select the "Penguin Reader Writer"
6. Run a simple select statement:
```sql

```
It successfully returns 10 records from the table. 
Now let's try an update statement:
```sql
UPDATE penguins SET island = 'Antarctica' WHERE sex = 'MALE' AND island = 'Torgersen';
```
It successfully updates 23 records.
But if we try to delete some records with 
```sql
DELETE FROM penguins WHERE islant='Antarctica' AND sex='MALE';
```

We get:
```sh
ERROR: permission denied for table penguins 
```
which verifies that the "penguin_reader_writer" role does not have delete privileges.

### Revoking privileges
Imagine now that, due to changes in the penguins organization hierarchy, the "penguin_reader_writer" role must not have `UPDATE` privileges, only `SELECT` privilages. Let's see how we can revoke the `UPDATE` privileges:

###### PgAdmin
1. Right click on the "penguins" table in the *Object Explorer* panel.
2. Go to "Properties" -> "Security" -> Click the "Privileges" column of the "penguin_reader_writer" row.
3. Un-check the "Update" checkbox.
4. Click "Save".

###### Terminal
```sql
REVOKE UPDATE ON penguins, little_penguins TO penguin_reader_writer;
```

We can verify that the `UPDATE` privileges are revoked by running a simple update query:
```sql
UPDATE penguins SET island = 'Atlantis' WHERE sex = 'MALE' AND island = 'Antarctica';
```

which yields:
```sh
ERROR: permission denied for table penguins 
```