# MQTT-Tools
1) Setup 2 ubuntu VM machineswith hostnames mqttserver and mqttclient respectively

2) Install mosquitto, mosquitto clients, OpenSSL and libs

	sudo apt-get install openssl libssl-dev mosquitto mosquitto-clients

3) Stop the broker

	sudo service mosquitto stop

4) Change to certificate-generator directory and run gencert.sh

	cd certificate-generator

	./gencert.sh -c <client hostname/ip> -s <mqttbroker hostname/ip>

	The certificates are generated in the results folder
	Note: The client and server ip or hostname should be different else would lead to a openssl error

5) Change to mosquitto-tools directory and run mosquitto-setup.sh

	cd mosquitto-tools

	./mosquitto-setup.sh

	The configuration file is generated in the mosquitto folder.

6) Finally, copy the certificates from the results folder from step 4 and mosquitto.conf into /etc/mosquitto

	cd /etc/mosquitto
	mv mosquitto.conf mosquitto.conf.bkup
	cp results/* /etc/mosquitto
	cp mosquitto/mosquitto.conf /etc/mosquitto

7) Run the mosquitto broker

	sudo mosquitto -c /etc/mosquitto.conf
