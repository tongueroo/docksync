#!/bin/bash

APP_ROOT=${APP_ROOT:=$1}
APP_ROOT=${APP_ROOT:=/app} # defaults to /app

install() {
  if type rsync > /dev/null ; then
    echo "rsync already installed"
  else
    echo "installing rsync"
    apt-get install -y rsync
  fi
}

configure() {
  if [ -f /etc/rsyncd.conf ]; then
    echo "rsync already configured"
  else
    echo "configuring rsync"
    cat >> /etc/rsyncd.conf << EOF
uid = root
gid = root
use chroot = yes
pid file = /var/run/rsyncd.pid
log file = /dev/stdout

[volume]
    hosts deny = *
    hosts allow = 192.168.0.0/16 172.16.0.0/12
    read only = false
    path = $APP_ROOT
    comment = app folder
EOF
  fi
}

start() {
  if [ -f /var/run/rsyncd.pid ]; then
    echo "rsync already running"
  else
    echo "starting rsync"
    /usr/bin/rsync --daemon --config /etc/rsyncd.conf /bin/bash
  fi
}

main() {
  install
  configure
  start
}

main