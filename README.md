# AWS IoT Example Project

AWS IoT simulator based on [this AWS Blog Post](https://aws.amazon.com/blogs/iot/device-simulation-with-aws-iot-and-aws-lambda/).

### Requirements

 - [NodeJS 8.10](https://nodejs.org/en/)
 - [cfnctl](https://github.com/stelligent/cfnctl/)

# Setup

Deploy the Lambda function

cfnctl lambda deploy -s ./simulator/src

Deploy your stack

```
cfnctl deploy -s iot-simulator-neil -t ./simulator/simulator.yaml -p ./simulator/parameters.json
```

Once your stack is deployed