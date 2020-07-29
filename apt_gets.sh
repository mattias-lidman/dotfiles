#!/usr/bin/env bash

PACKAGES="
	vim
	tree
	htop
	python-dev
	ctags
	virtualenv
	python-pip
	jq
"

apt-get update

for package in $PACKAGES; do
	apt-get install $package -y
done

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
dpkg -i ripgrep_0.8.1_amd64.deb
rm -f ripgrep_0.8.1_amd64.deb
