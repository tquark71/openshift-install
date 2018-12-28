cd ~/openshift-ansible
ansible-playbook -i ../openshift-install/openshift_inventory playbooks/deploy_cluster.yml 2>&1 | tee /tmp/deploy.log
