#!/bin/bash
# create_proxy_server_keypair.sh
# -----------------------------------------------------------------------------
# Purpose : create and upload keypair for new domains
# -----------------------------------------------------------------------------
# Usage :
#   $ create_proxy_server_keypair.sh env domain
#       env - dev | dev2 | k1 | k3 | prd
#       region - ap-northeast-1 | ap-southeast-2
#       domain - routing | msg-level1-bot |  msg-level2-bot | msg-level3-bot | msg-level4-bot
#       cluseter_name - le-connector | messaging-event-manager
#
# -----------------------------------------------------------------------------

env=$1
region=$2

key_name=$env'_packer_keypair'
echo $key_name
aws ec2 create-key-pair --key-name $key_name --profile $env --region $region \
| jq -r '.KeyMaterial' | tee $key_name'.pem'
aws s3 cp $key_name'.pem' 's3://'$env'-packer-keypair-bucket/'$region'/' --profile $env
chmod 600 $key_name'.pem'
mv $key_name'.pem' ~/.ssh/
