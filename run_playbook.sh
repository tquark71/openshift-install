cd ~/openshift-ansible
echo Running playbook $1
ansible-playbook -i openshift_inventory $1 2>&1 | tee /tmp/run_playbook.log
