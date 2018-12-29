INVENTORY=../openshift-install/openshift_inventory

cd ~/openshift-ansible
ansible-playbook -i $INVENTORY playbooks/adhoc/uninstall_openshift.yml 2>&1 | tee /tmp/uninstall.log
