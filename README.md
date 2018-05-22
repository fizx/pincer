This will spin up a trivial, self-contained ipfs pinning server that's backed by S3.

It uses CloudFormation to keep itself self-contained, and launches a t2.micro that can only talk to a newly created S3 bucket.  It's secured with a SSL+self-signed certificate, and an api key.

Look at server.rb for a description of the API.  

The API itself is pretty inefficient, but the whole thing should be reliable, cheap as dirt, and as under your own personal control as anything really gets in the cloud.

PRs welcome, this project is super-early.

[![Launch](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=ipfs-pin-server&templateURL=https://kmxdatasets.s3.amazonaws.com/pincer.yaml)