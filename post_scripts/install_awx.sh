#!/bin/bash
#
#AWX 11.2 Install for CentOS 7
#
#Based on https://github.com/ansible/awx/blob/devel/INSTALL.md#getting-started
#and https://www.howtoforge.com/tutorial/centos-ansible-awx-installation/
#and https://redhatnordicssa.github.io/ansible-podman-containers-2
#and https://www.youtube.com/watch?v=iIQ62T-Gsxw
#To Do:  Fix command absolute paths
#
yum install -y epel-release
yum install -y ansible
yum install -y git
yum install -y python3
#Install Docker
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum update -y
yum install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
systemctl enable docker
cd /srv
git clone -b 11.2.0 https://github.com/ansible/awx.git
git clone https://github.com/ansible/awx-logos.git
pip3 install docker-compose #(or should this be pip3 install docker?)
cd awx/installer
ansible-playbook -i inventory install.yml
