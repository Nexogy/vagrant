#!/usr/bin/env bash

echo "---------------------------------------------------------------"
echo "BOOTING SCRIPT"
echo "---------------------------------------------------------------"


echo "Starting MailCatcher"
mailcatcher

echo "Running IP-Tables flush"
iptables -F