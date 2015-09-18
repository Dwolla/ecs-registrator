#!/bin/sh
export LOCAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
echo Running: registrator -ip $LOCAL_IP $@ consul://$LOCAL_IP:8500
exec registrator -ip $LOCAL_IP "$@" consul://$LOCAL_IP:8500
