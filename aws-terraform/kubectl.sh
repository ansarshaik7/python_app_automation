#!/bin/bash

echo "Installing kubectl..."

# Check existing kubectl
if command -v kubectl &>/dev/null
then
    echo "kubectl already installed"
    kubectl version --client
    exit 0
fi


# Download kubectl for EKS 1.33
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/amd64/kubectl


# Give execute permission
chmod +x kubectl


# Move binary
sudo mv kubectl /usr/local/bin/kubectl


# Verify
kubectl version --client

if [ $? -eq 0 ]
then
    echo "kubectl installed successfully"
else
    echo "kubectl installation failed"
    exit 1
fi

echo "Updating kubeconfig..."

aws eks update-kubeconfig \
--region ap-south-1 \
--name python-app-eks


echo "Checking nodes..."

kubectl get nodes