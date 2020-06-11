#  Deployment tests

# Deploy a darknode in with AWS
darknode up --aws --name mainnet-testing-aws --aws-access-key  $aws_access_key --aws-secret-key $aws_secret_key --network mainnet --tags mainnet,testing
darknode list
darknode down mainnet-testing-aws -f

# Return error when providing no name
darknode up --aws
if [ "$?" -eq "0" ]; then
    exit "failed to pass test without providing a node name"
fi

# TODO : deploy node with specific region and instance type

# Return error when providing an empty name
darknode up --aws --name ""
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing an empty name"
fi

# Return error when providing an invalid network name
darknode up --aws --name testing --network invalid-network
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing an invalid network"
fi

# Return error when providing an invalid AWS credentials
darknode up --aws --name testing --aws-access-key key --aws-secret-key value
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing invalid credentials"
fi
rm -rf $HOME/.darknode/darknodes/testing

# Return error when providing an invalid aws region
darknode up --aws --name testing --aws-access-key  $aws_access_key --aws-secret-key $aws_secret_key --aws-region invalid-region
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing invalid region"
fi

# Return error when providing an invalid aws instance type
darknode up --aws --name testing --aws-access-key  $aws_access_key --aws-secret-key $aws_secret_key --aws-instance invalid-instance
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing invalid instance"
fi

echo "All AWS tests passed!"