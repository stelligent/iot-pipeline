# AWS IoT Example Project

AWS IoT simulator based on [this AWS Blog Post](https://aws.amazon.com/blogs/iot/device-simulation-with-aws-iot-and-aws-lambda/).

### Requirements

 - [NodeJS 8.10](https://nodejs.org/en/)
 - [cfnctl](https://github.com/stelligent/cfnctl/)

# Setup

Deploy your stack

```
cfnctl deploy -s iot-simulator -t ./iot.yaml -p ./parameters.json
```

Upload the Lambda function to S3

```
cfnctl lambda -s ./simulator/src
```

Deploy the Lambda stack

```
cfnctl deploy -s iot-simulator-lambda -t ./simulator/simulator.yaml -p ./simulator/parameters.json
```

Create a test event in the simulator lambda

```
{
  "esEndpoint": "search-iot-es-us-west-2-sadf98asdg9fg90dafg90adg9dfg.us-west-2.es.amazonaws.com",
  "esDomainArn": "arn:aws:es:us-west-2:0000000000000:domain/iot-es-us-west-2",
  "topic": "simulator_rule",
  "simTime": 10000,
  "interval": 500,
  "numDevice": 3
}
```

endpoint: azfy710l5pbus.iot.us-west-2.amazonaws.com
cert: 821c1177cc.cert.pem
thing: nxp-lpc54018-dev 