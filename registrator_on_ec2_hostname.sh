#!/bin/sh
export HOST=$(curl -s 169.254.169.254/latest/meta-data/local-hostname)
export LOCAL_IP=$(curl -s 169.254.169.254/latest/meta-data/local-ipv4)
registrator consul://$(curl -s 169.254.169.254/latest/meta-data/local-ipv4):8500

