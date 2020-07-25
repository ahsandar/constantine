#!/bin/sh
sudo mv /etc/resolv.conf.bak /etc/resolv.conf
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service