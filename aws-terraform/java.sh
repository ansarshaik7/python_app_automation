# !/bin/bash

# Install java in EC2 server
sudo yum update -y

if java -version &>/dev/null; then
    version=$(java -version 2>&1 | grep -oP '"\K[0-9]+' | head -1)
    echo "Java is already installed. Version: $version"
else
    echo "java version is not installed. Installing....."
    sudo yum install java -y

    if [ $? -eq 0 ]; then
        echo "java version is installed sucessfully."
    else
        echo "java version install failed....."
        exit 1
    fi
fi

# verify java installation
java --version
if [ $? -eq 0 ]; then
    echo "Java version  is installed and verified successfully."
else
    echo "Java version is not installed or not displaying properly. Exiting."
    exit 1
fi

# Detect JAVA_HOME path
java_path=$(readlink -f $(which java))
JAVA_HOME=$(dirname $(dirname "$java_path"))

# Export JAVA_HOME and update PATH
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Apply the changes
source ~/.bashrc

echo $JAVA_HOME

java --version