cd ~/openshift-ansible
ansible-playbook -i ../openshift-install/openshift_inventory playbooks/adhoc/uninstall_openshift.yml 2>&1 | tee /tmp/uninstall.log
