!#/bin/sh
hammer -u <username> -p <password> os create
--name CentOS \
--major 9 \
--architectures x86_64 \
--partition-tables "Kickstart default" \
--media "CentOS 8 mirror"
