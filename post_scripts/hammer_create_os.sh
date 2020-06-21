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

#Find and set OS and Template IDs
FNSHID=$(hammer --csv template list --search 'name = "Kickstart default finish"' | grep -v Id | awk -F, {'print $1'})
PROVID=$(hammer --csv template list --search 'name = "Kickstart default"' | grep -v Id | awk -F, {'print $1'})
PXELID=$(hammer --csv template list --search 'name = "Kickstart default PXELinux"' | grep -v Id | awk -F, {'print $1'})

# PXEID=$(hammer --csv template list | grep 'Kickstart default PXELinux' | awk -F, {'print $1'})
# SATID=$(hammer --csv template list | grep 'Satellite Kickstart Default' | awk -F, {'print $1'})
# for i in $(hammer --csv os list | awk -F, {'print $1'} | grep -vi '^ID')
#  do
#    hammer template add-operatingsystem --id="${PXEID}" --operatingsystem-id="${i}"
#    hammer os set-default-template --id="${i}" --config-template-id="${PXEID}"
#    hammer os add-config-template --id="${i}" --config-template-id="${SATID}"
#    hammer os set-default-template --id="${i}" --config-template-id="${SATID}"
#   done

#Update the Finish template
hammer os set-default-template \
--id 10 \
--provisioning-template-id $FNSHID #Kickstart default finish

#Update the Provisioning template
hammer os set-default-template \
--id 10 \
--provisioning-template-id $PROVID #Kickstart default

#Update the PXELinux template
hammer os set-default-template \
--id 10 \
--provisioning-template-id $PXELID #Kickstart default PXELinux

#hammer template add-operatingsystem \
#--name "Kickstart default" \
#--operatingsystem "CentOS 8"

#hammer template add-operatingsystem \
#--name "Kickstart default finish" \
#--operatingsystem "CentOS 8"

#hammer template add-operatingsystem \
#--name "Kickstart default PXELinux" \
#--operatingsystem "CentOS 8"
