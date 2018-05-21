#!/bin/bash
KEY=$1
BUCKET=$2

cd 
sudo apt-get update
sudo apt-get install -y awscli ruby haproxy

# Custom version of ipfs built from https://github.com/fizx/go-ipfs 
# adding the s3 datastore.
sudo wget https://ipfs.io/ipfs/QmdsFq3KhSSgjTKRtJ6nNVkJaJDY1TbJikJC2puvNisnUd -O /usr/local/bin/ipfs
sudo chmod +x /usr/local/bin/ipfs

ipfs init || true

echo '
require "json"
json = JSON.parse(File.read("/home/ubuntu/.ipfs/config"))
spec = {
    "path": "'$BUCKET'",
    "type": "s3"
}
json["Datastore"]["Spec"] = spec
File.open("/home/ubuntu/.ipfs/config", "w") {|f| f.puts json.to_json }
File.open("/home/ubuntu/.ipfs/datastore_spec", "w") {|f| f.puts spec.to_json }
' | ruby

screen -S ipfs -d -m ipfs daemon

openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
rm server.pass.key
openssl req -new -key server.key -out server.csr \
  -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
cat server.crt server.key > server.pem

sudo bash -c "echo ENABLED=1 >> /etc/default/haproxy"n
sudo wget https://ipfs.io/ipfs/QmNx7fAcx91PkHWMKBbaks7T3TFQUX5NA3WMNnwkgm3Bxw -O /etc/haproxy/haproxy.cfg
sudo service haproxy start
wget https://ipfs.io/ipfs/QmcEgzrPte2ErvuWtSNxGTpSy84hZQHTivYVbjnjyhBb6X -O server.rb
sudo gem install sinatra --no-rdoc --no-ri
screen -S ruby -d -m ruby server.rb "$KEY"