EC2_TYPE=c5.xlarge
IMAGE_ID=ami-06c8b4c8c78aeaa04 # amazon linux
KEY_NAME=ibc
SECURITY_GROUP=sg-017c7a31a0f052930


aws ec2 run-instances --image-id $IMAGE_ID --instance-type $EC2_TYPE --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --block-device-mappings file://mapping.json --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=IBC Setup}]' --region eu-west-1
echo As soon as the ec2 is ready copy the IP address
read IP_ADDRESS
ssh -i "key/${KEY_NAME}.pem" ec2-user@$IP_ADDRESS "sudo yum install git -y; git clone https://github.com/heliaxdev/ibc-setup"