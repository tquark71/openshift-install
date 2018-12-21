cd ~/openshift-ansible
ansible -i openshift_inventory OSEv3 -m copy -a "src=/etc/hosts dest=/etc"
