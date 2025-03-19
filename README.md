# SQL Data Mart project

![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

## Repository description

The repository contains 3 files:

- ```main.sql``` = schema definitions used to create database structure
- ```data.sql``` = mock data that can be utilized in order to test database
- ```tests.sql``` = retrieve queries used to test database with mock data

## System requirements

The project uses a PostgreSQL database; please have installed a local database server or run PostgreSQL instance as a container.

Tested with:

- Postgres v.16
- Postgres v.17

## Installation instructions

In order to install this project, please complete following steps:

1. Create a new PostgreSQL database
2. Import the schema from the ```main.sql``` file
- Import using the psql utility: run ```$ psql -U (user_name) -d (database_name) < main.sql```
- Import using the Beekeeper Studio: open __File__ -> __Import SQL files__ and the import the ```main.sql``` file
3. Import mock data from the ```data.sql``` file:
- Import using the psql utility: run ```$ psql -U (user_name) -d (database_name) < data.sql```
- Import using the Beekeeper Studio: open __File__ -> __Import SQL files__ and the import the ```data.sql``` file
4. Now you can run tests from ```tests.sql```

## Author

2025 Iurii Mednikov <iurii.mednikov@iu-study.org>

The code is delivered under terms of the MIT software license. For more information, check the LICENSE.txt file.