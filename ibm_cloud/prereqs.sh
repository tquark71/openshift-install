INVENTORY=../openshift-install/ibm_cloud/openshift_inventory

cd ~/openshift-ansible
ansible-playbook -i $INVENTORY playbooks/prerequisites.yml
