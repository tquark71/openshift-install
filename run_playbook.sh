cd ~/openshift-ansible
INVENTORY=../openshift-inventory/openshift_inventory

echo Running playbook $1
ansible-playbook -i $INVENTORY $1 2>&1 | tee /tmp/run_playbook.log
