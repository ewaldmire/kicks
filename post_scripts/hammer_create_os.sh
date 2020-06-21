!#/bin/sh
hammer -u <username> -p <password> os create \
--name CentOS \
--major 8 \
--architectures x86_64 \
--partition-tables "Kickstart default" \
--media "CentOS 8 mirror"

hammer -u <username> -p <password> template add-operatingsystem \
--name "Kickstart default" \
--operatingsystem "CentOS 8"

hammer -u <username> -p <password> template add-operatingsystem \
--name "Kickstart default finish" \
--operatingsystem "CentOS 8"

hammer -u <username> -p <password> template add-operatingsystem \
--name "Kickstart default PXELinux" \
--operatingsystem "CentOS 8"
