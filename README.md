# Tournament Results
A tournament results backend project in python 

#Quick Start 
- Install Virtual Box for your OS/platform from https://www.virtualbox.org/wiki/Downloads follows instructions
		- If your platform is Ubuntu 14.04 Note: If you are running Ubuntu 14.04, install VirtualBox using the 
		  Ubuntu Software Center, not the virtualbox.org web site.
		  Due to a reported bug, installing VirtualBox from the site may uninstall other software you need.
- Install vagrant from https://www.vagrantup.com/downloads for platform 
		- If your platform is windows please note that the vagrant Installer may ask you to grant network permissions
		  to Vagrant or make a firewall exception. Be sure to allow this.
- Clone the repo: `git clone https://github.com/udacity/fullstack-nanodegree-vm.git fullstack`
- Clone my repo: `git clone https://github.com/badrisugavanam/tournament.git tournament-results`
- Using the terminal or command prompty, change directory to fullstack/vagrant (cd fullstack/vagrant), 
  then type `vagrant up` to launch your virtual machine.
- Overwrite the files (tournament.sql,tournament.py,tournament_test.py) 
  from tournament-results directory onto full-stack/vagrant/tournament 
- From fullstack/vagrant directory go onto the VM by typing `vagrant ssh`
- Navigate to directory from inside VM by typing `cd /vagrant/tournament`
- type `psql` to launch postgres sql cli 
- type `\i tournament.sql`
- `\q` to quite the postgres sql cli 
- run the test cases by `python tournament_test.py`


#What's included 
```
tournament-results/
│   ├── tournament.py  
│   ├── tournament.sql 
│   ├── tournament_test.py  -- Run like python tournament_test.py
```