#!/bin/sh

nginx_conf="/etc/nginx/nginx.conf"
nginx_config_changed=8
nginx_watcher_sleep=4

nginx_config_last () {
  last=0;
  configs=$( ls $( cat ${nginx_conf} | grep -E "include .*[\.]conf" | sed -E 's/^.*include[ \t]*//' | sed -E 's/;.*$//' ) );
  for file in ${configs}; do
    modified=$(date -r ${file} +'%s');
    if [ ${modified} -gt ${last} ]; then
      last=${modified};
    fi
  done
  echo ${last};
}

nginx_test () {
  if [ -z "$(nginx -tq 2>&1)" ]; then
    echo "OK";
  else
    echo "";
  fi
}

nginx_started=0
while [ true ]; do
  if [ -n $(nginx_test) ]; then
    nginx_pids=$(ps | grep -E 'nginx[\:]' | awk '{ print $1 }');
    nginx_last=$(nginx_config_last);
    diff=$(( ${nginx_last} - ${nginx_started} ));
    if [ -z "${nginx_pids}" ]; then
      nginx &
      nginx_started=$(date +'%s');
    elif [[ ${diff} -lt 0 || ${diff} -gt ${nginx_config_changed} ]]; then
      nginx -s reload
      nginx_started=${nginx_last};
    fi
  fi
  sleep ${nginx_watcher_sleep}
done
echo "";
