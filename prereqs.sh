INVENTORY=../openshift-install/openshift_inventory

cd ~/openshift-ansible
ansible-playbook -i $INVENTORY playbooks/prerequisites.yml
