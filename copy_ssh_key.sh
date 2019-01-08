echo "Generating SSH key ..."
ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa

for host in os-master1.mooo.com os-infra1.mooo.com os-node1.mooo.com os-node2.mooo.com
do
  echo "Adding ${host} to known hosts ..."
  ssh-keyscan ${host} >> /root/.ssh/known_hosts
done

ansible OSEv3 -i ../openshift-install/openshift_inventory --ask-pass -m authorized_key -a 'key={{ lookup("file", "/root/.ssh/id_rsa.pub") }} state=present user=root'
