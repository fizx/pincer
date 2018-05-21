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