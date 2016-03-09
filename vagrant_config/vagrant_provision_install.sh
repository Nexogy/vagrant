#!/usr/bin/env bash

echo "---------------------------------------------------------------"
echo " "
echo " "
echo "      VAGRANT PROVISION INSTALLS"
echo " "
echo " "
echo "---------------------------------------------------------------"


echo "---------------------------------------------------------------"
echo "UPDATING APT-GET"
echo "---------------------------------------------------------------"
apt-get update

echo "---------------------------------------------------------------"
echo "INSTALLING GIT"
echo "---------------------------------------------------------------"
apt-get install -y git


echo "----------------------------------------------------------------"
echo "INSTALLING NGINX"
echo "----------------------------------------------------------------"
apt-get install -y nginx
service nginx stop

cp /vagrant/config/nginx_sites/etc/nginx/sites-available/nginx_vhost
ln -s /etc/nginx/sites-available/nginx_vhost/etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-available/default

#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi
service nginx start

echo "---------------------------------------------------------------"
echo "INSTALLING PHP"
echo "---------------------------------------------------------------"
apt-get install python-software-properties build-essential -y
add-apt-repository ppa:ondrej/php5 -y
apt-get update
apt-get install php5-common php5-dev php5-cli php5-fpm -y
echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql php5-sybase -y

echo "---------------------------------------------------------------"
echo "INSTALLING MYSQL"
echo "---------------------------------------------------------------"
apt-get install debconf-utils -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
apt-get install mysql-server -y

echo "---------------------------------------------------------------"
echo "INSTALLING COMPOSER"
echo "---------------------------------------------------------------"
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=/bin --filename=composer


echo "---------------------------------------------------------------"
echo "INSTALLING REDIS"
echo "---------------------------------------------------------------"
apt-get install -y redis-server

echo "---------------------------------------------------------------"
echo "INSTALLING NODEJS"
echo "---------------------------------------------------------------"
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "---------------------------------------------------------------"
echo "INSTALLING RUBY"
echo "---------------------------------------------------------------"
#apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev -y
#apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev -y
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#curl -L https://get.rvm.io | bash -s stable
\curl -sSL https://get.rvm.io | bash -s stable
#\curl -sSL https://get.rvm.io | bash -s stable --rails
#source ~/.rvm/scripts/rvm


#apt-add-repository ppa:rael-gc/rvm -y
#apt-get update
#apt-get install rvm -y
#rvm install ruby

echo "---------------------------------------------------------------"
echo "INSTALLING MAILCATCHER"
echo "---------------------------------------------------------------"
gem install mailcatcher

