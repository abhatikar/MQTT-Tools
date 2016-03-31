# MQTT-Tools
1) Setup 2 ubuntu machines over vm with hostnames mqttserver and mqttclient respectively
2) Install mosquitto, mosquitto clients, OpenSSL and libs
	sudo apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
	sudo apt-get update
        sudo apt-get install openssl libssl-dev mosquitto mosquitto-clients
4) Stop the broker
	sudo stop mosquitto
5) git clone this repository.
6) Modify the /etc/hosts file to add entries to client and server hostnames
