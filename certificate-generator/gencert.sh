#!/bin/bash
set -e
mkdir -p ~/myCA/signedcerts && mkdir ~/myCA/private 

cp caconfig.cnf ~/myCA
cp exampleclient.cnf ~/myCA
cp exampleserver.cnf ~/myCA

cd ~/myCA

echo '01' > serial  && touch index.txt

export OPENSSL_CONF=~/myCA/caconfig.cnf

openssl req -x509 -passout pass:rootkey -newkey rsa:2048 -out ~/myCA/cacert.pem -outform PEM -days 1825

openssl x509 -in ~/myCA/cacert.pem -out ~/myCA/cacert.crt

#Server Key

export OPENSSL_CONF=~/myCA/exampleserver.cnf

openssl req -passout pass:serverkey -newkey rsa:1024 -keyout ~/myCA/tempkey.pem -keyform PEM -out ~/myCA/tempreq.pem -outform PEM

openssl rsa < ~/myCA/tempkey.pem > ~/myCA/server_key.pem -passin pass:serverkey

mv ~/myCA/tempkey.pem ~/myCA/server_key.pem

export OPENSSL_CONF=~/myCA/caconfig.cnf

openssl ca -key rootkey -in ~/myCA/tempreq.pem -out ~/myCA/server_crt.pem

rm -f ~/myCA/tempkey.pem && rm -f ~/myCA/tempreq.pem

#Client Key

export OPENSSL_CONF=~/myCA/exampleclient.cnf

openssl req -passout pass:clientkey -newkey rsa:1024 -keyout ~/myCA/tempkey_c.pem -keyform PEM -out ~/myCA/tempreq_c.pem -outform PEM

openssl rsa < ~/myCA/tempkey_c.pem > ~/myCA/client_key.pem -passin pass:clientkey

mv ~/myCA/tempkey_c.pem ~/myCA/client_key.pem

export OPENSSL_CONF=~/myCA/caconfig.cnf

openssl ca -key rootkey -in ~/myCA/tempreq_c.pem -out ~/myCA/client_crt.pem

rm -f ~/myCA/tempkey_c.pem && rm -f ~/myCA/tempreq_c.pem
