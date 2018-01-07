var mqtt = require('mqtt');
var fs = require('fs');

var KEY = fs.readFileSync('client.key');
var CERT = fs.readFileSync('client.crt');
var CAfile = [fs.readFileSync('all-ca.crt')];

var options = {
host: '192.168.56.101',
port: 8883,
protocol: 'mqtts',
protocolId: 'MQIsdp',
ca: CAfile,
key: KEY,
cert: CERT,
secureProtocol: 'TLSv1_2_method',
protocolId: 'MQIsdp',
protocolVersion: 3,
rejectUnauthorized: false
};

var client = mqtt.connect(options);
client.on('connect', function() { // When connected
    console.log('connected');
    // publish a message to a topic
    client.publish('topic1/hello', 'my message', function() {
        console.log("Message is published");
        client.end(); // Close the connection when published
    });
});
