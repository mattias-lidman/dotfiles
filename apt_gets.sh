#!/usr/bin/env bash

PACKAGES="
    vim
    tree
    htop
    keychain
    python-dev
    ctags
    virtualenv
    python-pip
    jq
    unzip
"

apt-get update

for package in $PACKAGES; do
	apt-get install $package -y
done

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
dpkg -i ripgrep_0.8.1_amd64.deb
rm -f ripgrep_0.8.1_amd64.deb

mkdir awstemp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awstemp/awscliv2.zip"
unzip awstemp/awscliv2.zip -d awstemp
./awstemp/aws/install
rm -rf awstemp
