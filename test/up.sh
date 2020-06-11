#  Deployment tests

#  1. Deploy a darknode in with AWS
darknode up --aws --name mainnet-testing-aws --aws-access-key  $aws_access_key --aws-secret-key $aws_secret_key --network mainnet --tags mainnet,testing

darknode list

darknode down mainnet-testing-aws -f



