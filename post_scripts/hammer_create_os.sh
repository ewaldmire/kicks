#!/bin/bash

#Configure passwordless Hammer here: https://access.redhat.com/solutions/1612123
#Basically - update username & password in: ~/.hammer/cli.modules.d/foreman.yml
#For more ideas, see:  https://blog.fite.cat/tag/hammer/

#Look into if I can NOT setup the subnet after turning off DHCP stuffs with this:  https://access.redhat.com/solutions/3520211

#Need to add hammer command to change OpenSuse repo from download.opensuse.org to rsync.opensuse.org - the former no longer works but is the foreman default.

#Need to
#1) Prompt for Domain
DOMNAME="mynetwork.com"
#2) Prompt for Subnet
SUBNAME="MyNetwork"

##################
#CentOS 8        #
##################
hammer os create \
--name CentOS \
--major 8 \
--architectures x86_64 \
--partition-tables "Kickstart default" \
--media "CentOS 8 mirror" \
--provisioning-templates "Kickstart default,Kickstart default finish,Kickstart default PXELinux"

#Find and set OS and Template IDs
OSID=$(hammer --csv os list --search 'title = "CentOS 8"' | grep -v Id | awk -F, {'print $1'})
FNSHID=$(hammer --csv template list --search 'name = "Kickstart default finish"' | grep -v Id | awk -F, {'print $1'})
PROVID=$(hammer --csv template list --search 'name = "Kickstart default"' | grep -v Id | awk -F, {'print $1'})
PXELID=$(hammer --csv template list --search 'name = "Kickstart default PXELinux"' | grep -v Id | awk -F, {'print $1'})

#Update the Finish template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $FNSHID #Kickstart default finish

#Update the Provisioning template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $PROVID #Kickstart default

#Update the PXELinux template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $PXELID #Kickstart default PXELinux

##################
#Ubuntu 18.04 LTS#
##################
hammer os create \
--name Ubuntu \
--release-name bionic \
--major 18 \
--minor 04 \
--description "Ubuntu 18.04 LTS" \
--architectures x86_64 \
--partition-tables "Preseed default" \
--media "Ubuntu mirror" \
--provisioning-templates "Preseed default,Preseed default finish,Preseed default PXELinux"

#Find and set OS and Template IDs
OSID=$(hammer --csv os list --search 'title = "Ubuntu 18.04 LTS"' | grep -v Id | awk -F, {'print $1'})
FNSHID=$(hammer --csv template list --search 'name = "Preseed default finish"' | grep -v Id | awk -F, {'print $1'})
PROVID=$(hammer --csv template list --search 'name = "Preseed default"' | grep -v Id | awk -F, {'print $1'})
PXELID=$(hammer --csv template list --search 'name = "Preseed default PXELinux"' | grep -v Id | awk -F, {'print $1'})

#Update the Finish template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $FNSHID #Preseed default finish

#Update the Provisioning template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $PROVID #Preseed default

#Update the PXELinux template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $PXELID #Preseed default PXELinux
###########################################

##################
#Ubuntu 16.04 LTS#
##################
hammer os create \
--name Ubuntu \
--release-name xenial \
--major 16 \
--minor 04 \
--description "Ubuntu 16.04 LTS" \
--architectures x86_64 \
--partition-tables "Preseed default" \
--media "Ubuntu mirror" \
--provisioning-templates "Preseed default,Preseed default finish,Preseed default PXELinux"

#Find and set OS and Template IDs
OSID=$(hammer --csv os list --search 'title = "Ubuntu 16.04 LTS"' | grep -v Id | awk -F, {'print $1'})
FNSHID=$(hammer --csv template list --search 'name = "Preseed default finish"' | grep -v Id | awk -F, {'print $1'})
PROVID=$(hammer --csv template list --search 'name = "Preseed default"' | grep -v Id | awk -F, {'print $1'})
PXELID=$(hammer --csv template list --search 'name = "Preseed default PXELinux"' | grep -v Id | awk -F, {'print $1'})

#Update the Finish template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $FNSHID #Preseed default finish

#Update the Provisioning template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $PROVID #Preseed default

#Update the PXELinux template
hammer os set-default-template \
--id $OSID \
--provisioning-template-id $PXELID #Preseed default PXELinux
###########################################

#Create a Domain
#hammer domain create --name $DOMNAME #Not needed - default already created upon install

#Find Domain ID:
DOMID=$(hammer --csv domain list --search 'name = '$DOMNAME'' | grep -v Id | awk -F, {'print $1'})

#Create a Subnet w/ Default TFTP Proxy
hammer subnet create --name "${SUBNAME}" --network 192.168.1.0 --mask 255.255.255.0 --domain-ids=$DOMID --tftp-id=1

#Create a CentOS 8 Hostgroup
MEDID=$(hammer --csv medium list | grep 'CentOS 8 mirror' | awk -F, {'print $1'})
# ENVID=$(hammer --csv environment list | grep rhel_7_server_x86_64  | grep -i dev | grep -v epel | awk -F, {'print $1'})  #DONT CARE ABOUT THIS... RIGHT?
PARTID=$(hammer --csv partition-table list | grep 'Kickstart default,Redhat' | awk -F, {'print $1'})
OSID=$(hammer --csv os list | grep 'CentOS 8,,Redhat' | awk -F, {'print $1'})
# CAID=1 #DONT CARE ABOUT THIS... RIGHT?
# PROXYID=1 #DONT CARE ABOUT THIS... RIGHT?
hammer hostgroup create --architecture="x86_64" --domain="${DOMNAME}" --medium-id="${MEDID}" --name="CentOS 8 HostGroup" --subnet="${NETNAME}" --partition-table-id="${PARTID}" --operatingsystem-id="${OSID}" --subnet="${SUBNAME}" # --environment-id="${ENVID}" --puppet-ca-proxy-id="${CAID}" --puppet-proxy-id="${PROXYID}"
