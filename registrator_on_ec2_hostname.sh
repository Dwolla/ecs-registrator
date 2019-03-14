#!/bin/bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

function deregister {
  registrator_exit_code=$?
  echo "Registrator has exited; cleaning up containers registered on this instance" > /dev/stderr
  set -o xtrace
  curl --silent "http://${LOCAL_IP}:8500/v1/agent/services" | \
    jq -r "map(\"http://${LOCAL_IP}:8500/v1/agent/service/deregister/\(.ID)\") | .[]" | \
    xargs curl --silent --verbose -XPUT
  exit ${registrator_exit_code}
}
trap deregister EXIT

LOCAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
export LOCAL_IP
echo "Running: registrator -ip ${LOCAL_IP} $* consul://$LOCAL_IP:8500" > /dev/stderr
registrator -ip "${LOCAL_IP}" "$@" "consul://${LOCAL_IP}:8500"
