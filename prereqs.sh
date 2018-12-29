INVENTORY=../openshift-inventory/openshift_inventory

cd ~/openshift-ansible
ansible-playbook -i $INVENTORY playbooks/prerequisites.yml
