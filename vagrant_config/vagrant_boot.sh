#!/usr/bin/env bash

echo "---------------------------------------------------------------"
echo "BOOTING SCRIPT"
echo "---------------------------------------------------------------"


echo "Starting MailCatcher"
mailcatcher

echo "Running IP-Tables flush"
iptables -F

echo "DNA Config"
cd /var/www/dna

echo "installing missing gems"
# update the bundles to get thin server
gem install bundle
echo 'starting thin server'
#start thin server
thin -R faye/config.ru start -C faye/thin_development.yml

# Checking for HybridAuthLog files.
echo 'checking for hybridauth.log file'
if [ ! -e /var/www/dna/app/storage/logs/hybridauth.log ]
then
	touch '/var/www/dna/app/storage/logs/hybridauth.log'
	echo 'created hybridauth.log file.'
else
	echo 'file exists.'
fi