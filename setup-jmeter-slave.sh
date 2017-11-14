#!/bin/bash

SERVER_PORT=${1?'Server port is not defined'}
RMI_LOCAL_PORT=${2?'RMI local port is not defined'}

apt-get update

apt-get install default-jre -y

# http://jmeter.apache.org/download_jmeter.cgi
wget http://xenia.sote.hu/ftp/mirrors/www.apache.org//jmeter/binaries/apache-jmeter-3.3.zip

apt-get install unzip -y

unzip apache-jmeter-3.3.zip

# Optional: Add JMeter plugins

cd apache-jmeter-3.3/bin

# JMeter server properties
echo "server_port=$SERVER_PORT" >> jmeter.properties
echo "server.rmi.localport=$RMI_LOCAL_PORT" >> jmeter.properties

echo "All done. Open ssh tunnel and run the server."

# SSH tunnel on client
# ssh -L $SERVER_PORT:127.0.0.1:$SERVER_PORT -R 12345:127.0.0.1:12345 -L $RMI_LOCAL_PORT:127.0.0.1:$RMI_LOCAL_PORT -N -f root@1.2.3.4

# Optional: scp test data to servers (only the test plan is sent by the client)
# scp file root@1.2.3.4:/root/...

# Start JMeter server
# ./jmeter-server.sh -Djava.rmi.server.hostname=127.0.0.1

# JMeter client configuration
# remote_hosts=127.0.0.1:$SERVER_PORT
# client.rmi.localport=12345
# mode=Statistical
# summariser.interval=10

# Run test scenario on JMeter client
# ./jmeter.sh -Djava.rmi.server.hostname=127.0.0.1 -n -t testScenario.jmx -r -l result.jtl