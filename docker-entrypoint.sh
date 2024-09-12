#!/bin/bash

actCode=$1
case "${actCode}" in
  start)
    cmd="/app/drms"
    config_path="/app/etc/drms.toml"
    cat ${config_path}

    args=" --configfile=$config_path"
    echo "$cmd $args"
    /bin/sh -c "$cmd $args"
    ;;
  *)
    echo "actCode=${actCode} is invalid." > /dev/stderr
    exit 1
    ;;
esac
