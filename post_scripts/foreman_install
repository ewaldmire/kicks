#!/bin/bash
#
#Foreman 2 Install for CentOS 7 w/ Salt Module
#
#Based on https://theforeman.org/manuals/2.0/quickstart_guide.html
#To Do:  create variables for /etc/hosts entry
#Create command to edit /etc/sudoers
#Correctly setup firewall - don't just turn it off!
#
#
#When it's done you should be able to find the password here:
#/etc/foreman-installer/scenarios.d/foreman-answers.yaml
#/root/.hammer/cli.modules.d/foreman.yml
#
yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://yum.theforeman.org/releases/2.0/el7/x86_64/foreman-release.rpm
yum -y install foreman-release-scl
yum -y install foreman-installer
echo "192.168.25.42 captain.avengers.lan foreman" >> /etc/hosts
######################################
#Install Foreman with different User #
######################################
#sudo foreman-installer \
#	--foreman-user=foremansvc \
#	--foreman-group=foremansvc \
#	--foreman-db-username=foremansvc \ 
#	--foreman-pam-service=foremansvc \
#	--puppet-server-reports=foremansvc \
#	--enable-foreman-plugin-salt \
#	--enable-foreman-proxy-plugin-salt
######################################
#Install Foreman with DHCP and TFTP enabled   #
######################################
foreman-installer \
  --enable-foreman-proxy \
  --foreman-proxy-dhcp=true \
  --foreman-proxy-dhcp-interface=enp1s0 \
  --foreman-proxy-dhcp-gateway=192.168.25.1 \
  --foreman-proxy-dhcp-range="192.168.25.101 192.168.25.149" \
  --foreman-proxy-dhcp-nameservers="192.168.25.55,192.168.25.1" \
  --foreman-proxy-dhcp-search-domains="foreman.lan" \
  --enable-foreman-plugin-dhcp-browser \
  --foreman-proxy-tftp true
### Maybe add --foreman-proxy-tftp-servername $(hostname)
### See https://access.redhat.com/solutions/2832531
######################################
#Install Foreman with Salt plugin    #
######################################
#foreman-installer --enable-foreman-plugin-salt --enable-foreman-proxy-plugin-salt #--foreman-proxy-dhcp=true 
######################################
#Install Foreman without Puppet      #
######################################
foreman-installer --foreman-proxy-dhcp-managed false # --no-enable-puppet --foreman-proxy-puppet false --foreman-proxy-puppetca false --no-enable-foreman-proxy #Doesn't work
#Also need to try adding:  --foreman-admin-username admin  --foreman-admin-password {Enter_Password}

#Install foreman-maintain too (for backups and ??)
dnf install rubygem-foreman_maintain rubygem-foreman_maintain-doc -y

systemctl stop firewalld
systemctl disable firewalld
yum install -y mlocate
updatedb

curl -O https://raw.githubusercontent.com/ewaldmire/kicks/master/post_scripts/hammer_create_os.sh

########################################################################
#Everything Below Here are more "notes" to myself that a working script#
########################################################################

####Add this to /etc/sudoers:
## foreman-salt setup
#Cmnd_Alias SALT = /usr/bin/salt, /usr/bin/salt-key
#foreman-proxy ALL = (ALL) NOPASSWD: SALT
#Defaults:foreman-proxy !requiretty


#rest_cherrypy:
#  port: 9191
#  host: 0.0.0.0
#  ssl_key: /etc/puppetlabs/puppet/ssl/private_keys/foreman.avengers.lan.pem
#  ssl_crt: /etc/puppetlabs/puppet/ssl/certs/foreman.avengers.lan.pem


#sudo yum install https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el7.noarch.rpm
#yum install -y salt-master
#yum install -y salt-minion
#yum install -y salt-api
#yum install -y python-cherrypy

#file /usr/bin/cherryd from install of 
#python-cherrypy-3.2.2-4.el7.noarch conflicts with file from package 
#python36-cherrypy-5.6.0-6.el7.noarch


#salt-plugin:
#tfm-rubygem-smart_proxy_salt <--- installed this and had things half working
#tfm-rubygem-foreman_remote_execution <----later installed this and broke some stuff, then removed it and it removed the first one!!?

#ln -s /opt/rh/rh-ruby25/root/usr/lib64/libruby.so.2.5 /lib64/libruby.so.2.5

#systemctl start smart_proxy_dynflow_core
#systemctl enable smart_proxy_dynflow_core

#yum install -y tfm-rubygem-foreman-tasks


#ln -s /opt/theforeman/tfm/root/usr/share/gems/gems/foreman-tasks-1.1.1/deploy/foreman-tasks.service /usr/lib/systemd/system/foreman-tasks.service


######
#In foreman configure:  Go to Operating Systems and select Media and Partition Tables, associate kickstart provisioning templates with CentOS 7 Defined OS, setup IPV4 subnet & make sure all defaults are selected in subnet setup - then create host
