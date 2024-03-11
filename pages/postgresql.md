# Why PostgreSQL?
This is a valid question, especially if you are already familiar with other databases like `sqlite`, that are simpler to setup, run locally, and do not follow the client-server model. The answer is that the [client-server model](#what-is-the-client-server-model-after-all) that `postgresql` follows offers robustness, scalability, and effectiveness in handling large volumes of data. Furthermore, it provides enhanced concurrency with features like multi-line transactions. These above are necessary for modern, complex, real-world applications, and non-client-server databases (like `sqlite`) cannot guarantee them.

# What is the client-server model after all?
A **local** (non-client-server) database is designed to run on a single computer or device, storing data locally and accessed by applications on the same machine. This setup is ideal for standalone applications where simplicity and ease of deployment are priorities. On the other hand, a **client-server** database operates on a networked environment where the database server runs independently of client applications. Clients connect to the server over a network to query, update, and manage data. Of course, both the server and the client can live in the same machine, mainly for educational purposes, like in this tutorial.

# Setting up PostgreSQL on MacOS
We present two options to easily setup PostgreSQL on MacOS; the first one offers a very quick and simple setup, while the second one offers more flexibility and control over the configurations. Both will work fine for this tutorial.

## Option 1 (Postgres.app)
1. Download the latest version of Postgress.app from [here](https://postgresapp.com/downloads.html)
2. Open the downloaded `.dmg` file
3. Drag `Postgres.app` to the Applications folder
4. Open the Applications folder, then open `Postgres.app`. The first time you open the app, you might see a warning message because it was downloaded from the internet. If so, click "Open" to continue
5. You are ready to go. `Postgres.app` will automatically initialize a new PostgreSQL server with a default database. This process is typically quick and requires no user input.
6. Optional and advanced - only if you wish to use the command line tools as well:
    1. Open terminal
    2. Run `open ~/.zshrc` (or `~/.bashrc` depending on your terminal)
    3. Add the following line to the bottom of the file: `export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin`. Adjust the version number if necessary. Save the file.
    4. Run `source ~/.zshrc`
    5. Verify installation by running `psql`

## Option 2 (Direct installer)
1. Download the latest version of PostgreSQL for macOS from [here](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
2. Double-click the downloaded file to run the installer
    1. Click "Continue"
    2. Leave the default installation folder and click "Continue"
    3. Leave the default components and click "Continue"
    4. Leave the default location (the database files will be stored there). You will be prompted to create a password; make sure to remember it. Click "Continue"
    5. Leave the default options and click "Continue"
    6. Click "Install"; if requested, provide your Mac OS password (the one you use for unlocking your laptop)
    7. Click "Finish" or "Close"
3. Open *PgAdmin 4* from the *Applications* folder
    * If prompted, create a new password; make sure to remember this one as well
4. In the top-left corner of *PgAdmin*, expand the "Servers" option by clicking on it
5. Click "PostgreSQL"; if prompted, use the password you created in step 2.4
6. You are now connected to PostgreSQL; stay tuned to learn what database *privilages* are and how to manage them
