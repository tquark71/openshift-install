ansible masters -i ../openshift-install/openshift_inventory \
  -m shell \
  -a 'oc login -u system:admin -n default'

ansible masters -i ../openshift-install/openshift_inventory \
  -m copy \
  -a 'src=nfs-pv.yaml dest=/tmp/nfs-pv.yaml'

ansible masters -i ../openshift-install/openshift_inventory \
  -m shell \
  -a 'oc create -f /tmp/nfs-pv.yaml'

ansible masters -i ../openshift-install/openshift_inventory \
  -m shell \
  -a 'oc get pv'
