# This file generates the keys and certificates used for testing mosquitto.
# None of the keys are encrypted, so do not just use this script to generate
# files for your own use.

rm -rf *.crt *.csr *.key rootCA/ signingCA/ *.pem

for a in root signing; do
	rm -rf ${a}CA/
	mkdir -p ${a}CA/newcerts
	touch ${a}CA/index.txt
	echo 01 > ${a}CA/serial
	echo 01 > ${a}CA/crlnumber
done
rm -rf certs

BASESUBJ="/C=GB/ST=Derbyshire/L=Derby/O=Mosquitto Project/OU=Testing"
SBASESUBJ="/C=GB/ST=Nottinghamshire/L=Nottingham/O=Server/OU=Production"

# The root CA
openssl genrsa -out test-root-ca.key 1024
openssl req -new -x509 -days 3650 -key test-root-ca.key -out test-root-ca.crt -config openssl.cnf -subj "${BASESUBJ}/CN=Root CA/"

# An intermediate CA, signed by the root CA, used to sign server/client csrs.
openssl genrsa -out test-signing-ca.key 1024
openssl req -out test-signing-ca.csr -key test-signing-ca.key -new -config openssl.cnf -subj "${BASESUBJ}/CN=Signing CA/"
openssl ca -config openssl.cnf -name CA_root -extensions v3_ca -out test-signing-ca.crt -infiles test-signing-ca.csr

# Valid server key and certificate.
openssl genrsa -out server.key 1024
openssl req -new -key server.key -out server.csr -config openssl.cnf -subj "${SBASESUBJ}/CN=mqttserver/"
openssl ca -config openssl.cnf -name CA_signing -out server.crt -infiles server.csr

# Valid client key and certificate.
openssl genrsa -out client.key 1024
openssl req -new -key client.key -out client.csr -config openssl.cnf -subj "${SBASESUBJ}/CN=mqttclient/"
openssl ca -config openssl.cnf -name CA_signing -out client.crt -infiles client.csr

cat test-signing-ca.crt test-root-ca.crt > all-ca.crt
cat client.crt client.key all-ca.crt > client.pem
c_rehash certs
