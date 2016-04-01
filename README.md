# MQTT-Tools
1) Setup 2 ubuntu machines over vm with hostnames mqttserver and mqttclient respectively

2) Install mosquitto, mosquitto clients, OpenSSL and libs

	sudo apt-add-repository ppa:mosquitto-dev/mosquitto-ppa

	sudo apt-get update

	sudo apt-get install openssl libssl-dev mosquitto mosquitto-clients

4) Stop the broker
	sudo stop mosquitto

5) Modify the /etc/hosts file to add entries to client and server hostnames

	127.0.0.1       localhost
	127.0.1.1       mqttserver
	192.168.56.102  mqttclient <---- Like this one

	# The following lines are desirable for IPv6 capable hosts
	::1     ip6-localhost ip6-loopback
	fe00::0 ip6-localnet
	ff00::0 ip6-mcastprefix
	ff02::1 ip6-allnodes
	ff02::2 ip6-allrouters

6) Change to certificate-generator directory and run gencert.sh

	cd certificate-generator

	./gencert.sh
