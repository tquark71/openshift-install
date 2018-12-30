oc login -u system:admin -n default
oc create -f nfs-pv.yaml
oc create -f nfs-claim.yaml
