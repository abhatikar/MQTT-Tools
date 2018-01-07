#!/usr/bin/env bash

# Replace set -e and exit with non-zero status if we experience a failure
trap 'exit' ERR

# Default location - overwritten with preceding path if one of them exists
MOSQHOME=./mosquitto

# Mosquitto configuration filename
MOSQCONF=mosquitto.conf

# Time stamp format for backing up configuration files
tstamp=$(date +%Y%m%d-%H%M%S)

# Fall back to default /tmp/mosquitto and create this location if it doesn't exist
[ -d $MOSQHOME ] || mkdir $MOSQHOME

# Concat of path and configuration file
MOSQPATH=$MOSQHOME/$MOSQCONF

# If file exists, move it to a timestamp-based name
if [ -f $MOSQPATH ]; then
	echo -n "Saving previous configuration: "
	mv -v $MOSQPATH $MOSQHOME/$MOSQCONF-$tstamp
fi

sed -Ee 's/^[ 	]+%%% //' <<!ENDMOSQUITTOCONF > $MOSQPATH
	%%% # allow_anonymous false
	%%% autosave_interval 1800
	%%% 
	%%% connection_messages true
	%%% log_dest stderr
	%%% log_dest topic
	%%% log_type error
	%%% log_type warning
	%%% log_type notice
	%%% log_type information
	%%% log_type all
	%%% log_type debug
	%%% log_timestamp true
	%%% 
	%%% #message_size_limit 10240
	%%% 
	%%% #password_file jp.pw
	%%% #acl_file jp.acl
	%%% 
	%%% persistence true
	%%% persistence_file mosquitto.db
	%%% persistent_client_expiration 1m
	%%% 
	%%% #pid_file xxxx
	%%% 
	%%% retained_persistence true
	%%% 
	%%% #listener 1883
	%%% listener 1883 127.0.0.1
	%%% 
	%%% listener 8883
	%%% tls_version tlsv1.2
	%%% cafile $MOSQHOME/all-ca.crt
	%%% certfile $MOSQHOME/server.crt
	%%% keyfile $MOSQHOME/server.key
	%%% require_certificate true
!ENDMOSQUITTOCONF

chmod 640 $MOSQPATH
echo "Please adjust certfile and keyfile path names in $MOSQPATH"
