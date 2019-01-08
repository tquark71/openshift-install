INVENTORY=../openshift-install/openshift_inventory

ansible-playbook -i $INVENTORY openshift-ansible/playbooks/deploy_cluster.yml 2>&1 | tee /tmp/deploy.log
