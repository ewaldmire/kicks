lang en_US
keyboard us
timezone America/Chicago
rootpw $1$X0gnAgiT$pulEEcBlZ0gxfAZu.fTGc0 --iscrypted #Dumb password to change pre-prod
#platform x86, AMD64, or Intel EM64T
reboot
# Network information
network --activate --bootproto=dhcp --hostname=laptop.local
#Installation type: graphical
text
#X Window system configuration information
xconfig --startxonboot
cdrom
bootloader --location=mbr --append="rhgb quiet crashkernel=auto"
zerombr
clearpart --all --initlabel
autopart
auth --passalgo=sha512 --useshadow
selinux --enforcing
#firewall --enabled --ssh
#skipx
#create user for me!
user --name=ewaldmire
firstboot --disable
%post
#Update Base OS
yum update -y
#Install EPEL Repo
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
#Install Saltstack Minion
yum install -y https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm
yum clean expire-cache
dnf install -y salt-minion
systemctl enable salt-minion
systemctl start salt-minion
#Install Google Chrome
dnf install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
#Install Slack
dnf install -y https://downloads.slack-edge.com/linux_releases/slack-4.11.3-0.1.fc21.x86_64.rpm
#Install Zoom
dnf install -y https://zoom.us/client/latest/zoom_x86_64.rpm
#Install Microsoft Teams
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[teams]\nname=teams\nbaseurl=https://packages.microsoft.com/yumrepos/ms-teams\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/teams.repo' 
dnf check-update
dnf install -y teams
#Install OpenVPN
dnf install -y NetworkManager-openvpn-gnome
dnf install -y keepassxc
#Install Spotify
dnf install -y snapd
systemctl enable snapd
systemctl start snapd
snap install spotify
dnf group install 'Office Suite and Productivity' -y
#Update mlocate database
updatedb
%end
%packages
@^workstation-product-environment
kexec-tools
%end


