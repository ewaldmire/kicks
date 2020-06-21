#!/bin/bash

#Configure passwordless Hammer here: https://access.redhat.com/solutions/1612123
#Basically - update username & password in: ~/.hammer/cli.modules.d/foreman.yml

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
