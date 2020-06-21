!#/bin/sh
hammer -u <username> -p <password> os create \
--name CentOS \
--major 8 \
--architectures x86_64 \
--partition-tables "Kickstart default" \
--media "CentOS 8 mirror" \
--provisioning-templates "Kickstart default,Kickstart default finish,Kickstart default PXELinux"

#Need to find OS ID and Template IDs

#Update the Default Templates
hammer -u <username> -p <password> os set-default-template \
--id OS ID \
--provisioning-template-id TPL ID

#hammer -u <username> -p <password> template add-operatingsystem \
#--name "Kickstart default" \
#--operatingsystem "CentOS 8"

#hammer -u <username> -p <password> template add-operatingsystem \
#--name "Kickstart default finish" \
#--operatingsystem "CentOS 8"

#hammer -u <username> -p <password> template add-operatingsystem \
#--name "Kickstart default PXELinux" \
#--operatingsystem "CentOS 8"
