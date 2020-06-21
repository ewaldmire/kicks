!#/bin/sh

#Configure passwordless Hammer here: https://access.redhat.com/solutions/1612123
#Basically - update username & password in: ~/.hammer/cli.modules.d/foreman.yml

hammer os create \
--name CentOS \
--major 8 \
--architectures x86_64 \
--partition-tables "Kickstart default" \
--media "CentOS 8 mirror" \
--provisioning-templates "Kickstart default,Kickstart default finish,Kickstart default PXELinux"

#Need to find OS ID and Template IDs
hammer template list --search "Kickstart default"

#Update the Finish template
hammer os set-default-template \
--id 10 \
--provisioning-template-id 51

#Update the Provisioning template
hammer os set-default-template \
--id 10 \
--provisioning-template-id 51 #Kickstart default

#Update the PXELinux template
hammer os set-default-template \
--id 10 \
--provisioning-template-id 51

#hammer template add-operatingsystem \
#--name "Kickstart default" \
#--operatingsystem "CentOS 8"

#hammer template add-operatingsystem \
#--name "Kickstart default finish" \
#--operatingsystem "CentOS 8"

#hammer template add-operatingsystem \
#--name "Kickstart default PXELinux" \
#--operatingsystem "CentOS 8"
