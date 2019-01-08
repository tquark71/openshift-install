INVENTORY=../openshift-install/openshift_inventory

ansible-playbook -i $INVENTORY openshift-ansible/playbooks/prerequisites.yml
