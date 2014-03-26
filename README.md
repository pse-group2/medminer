##README

Use git clone git@github.com:pse-group2/medminer.git to clone this project to your desired directory.

###Ruby Version

At the moment, we recommend using Ruby Version 2.0.0 with Rails 4.0.3.

###Running on localhost

To start the server, go to the project location and run 
```rails server```
In your browser, navigate to http://0.0.0.0:3000/ and you will see the homepage of the rails server.

###Treat

To install treat, run gem install treat in your console (or just bundle install in the project). For the additional language package, run in your irb the following:
```
require 'treat
Treat::Core::Installer.install 'german'
```
We use the the german language package here. For more more information, visit https://github.com/louismullie/treat/wiki/Manual#installing-treat-core

###MySQL

To connect to the MySQL database, we use the mysql2 gem. Install it (gem install mysql2) and modify the database.yml in your projects config folder:
```
development:
  adapter: mysql2
  database: dewiki
  username: root
  password: toor
  encoding: utf8
  port: 3306
  host: localhost
```
Fill in the corresponing values.
Make sure you have a mysql server installed. For Windows or Mac operating systems, there is xampp (http://www.apachefriends.org/de/index.html), which brings just all you need.
If you are on Debian, just do
```
sudo apt-get install mysql-server apache2 phpmyadmin
```
and start the services with ```sudo service apache2 start```.
