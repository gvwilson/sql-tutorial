# Setting up PostgreSQL on MacOS
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
