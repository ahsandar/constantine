#!/bin/sh
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved.service