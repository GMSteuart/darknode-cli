#  Deployment tests

# Deploy a darknode using DO
darknode up -do -name testing-do --do-token $do_token --tags testing
darknode list
darknode down testing-do -f

# Return error when providing no name
darknode up --do
if [ "$?" -eq "0" ]; then
    exit "failed to pass test without providing a node name"
fi

# TODO : deploy node with specific region and instance type

# Return error when providing an empty name
darknode up --do --name ""
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing an empty name"
fi

# Return error when providing an invalid network name
darknode up --do --name testing-do --do-token $do_token --network invalid-network
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing an invalid network"
fi

# Return error when providing an invalid digital ocean token
darknode up --do --name testing-do --do-token invalid-token
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing invalid credentials"
fi
rm -rf $HOME/.darknode/darknodes/testing

# Return error when providing an invalid digital ocean region
darknode up --do --name testing-do --do-token $do_token --do-region invalid-region
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing invalid region"
fi

# Return error when providing an invalid digital ocean droplet type
darknode up --do --name testing-do --do-token $do_token --do-droplet invalid-droplet-type
if [ "$?" -eq "0" ]; then
    exit "failed to pass test when providing invalid instance"
fi
darknode down testing-do -f

echo "All DO tests passed!"