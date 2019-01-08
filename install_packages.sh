ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m yum \
  -a 'update_only=yes'

ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m yum \
  -a 'name=epel-release state=present'


ansible OSEv3 -i ../openshift-install/openshift_inventory \
  -m yum \
  -a 'name="wget,git,perl,net-tools,docker-1.13.1,bind-utils,iptables-services,bridge-utils,openssl-devel,bash-completion,kexec-tools,sos,psacct,python-cryptography,python2-pip,python-devel,python-passlib,java-1.8.0-openjdk-headless,@Development Tools" state=present'
