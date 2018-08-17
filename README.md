# Tournament results

Python module that uses the PostgreSQL database to keep track of players and matches in a game tournament.

The game tournament uses the Swiss system for pairing up players in each round.

## Required Libraries and Dependencies
* Vagrant and VirtualBox - For installing the Vagrant VM https://www.udacity.com/wiki/ud197/install-vagrant

**What's included**

Within the download you will find the following directory and files.

```
tournament/
├── tournament.sql
├── tournament.py
├── tournament_test.py
```

## How to Run the Project
1. Fork https://github.com/navinesh/fullstack-nanodegree-vm
2. Clone the newly forked repository to your computer
3. Using the terminal, change directory to **vagrant** (cd vagrant), then type `vagrant up` to launch your virtual machine
4. Once it is up and running, type `vagrant ssh` to log into it
5. Change directory to **vagrant/tournament** (cd /vagrant/tournament)
6. Run the command `psql -f tournament.sql` to log into the database, create tables and views
7. Run the command `python tournament_test.py` to test database tables and views, and `tournament.py` module

## Extra Credit Description
Prevents rematches between players

## Creator
Navinesh Chand
* https://twitter.com/navinesh
* https://github.com/navinesh
