This will spin up a trivial, self-contained ipfs pinning server that's backed by S3.

It uses CloudFormation to keep itself self-contained. 

```
aws cloudformation create-stack \
  --stack-name=foo-`date +%s` \
  --template-body=file://cf.yaml 
  --parameters \
      ParameterKey=KeyName,ParameterValue=YOURKEYNAME \
      ParameterKey=OperatorEMail,ParameterValue=YOUREMAIL \ 
      ParameterKey=ApiKey,ParameterValue=YOURSECRET \
    --region us-west-2 \
    --capabilities CAPABILITY_IAM
````

or 

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=ipfs-pin-server&templateURL=https://kmxdatasets.s3.amazonaws.com/pincer.yaml)