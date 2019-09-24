# openshift-install

## 1 - Download Installation scripts

*Do this procedure in the Ansible server*

We have prepared some installation scripts for this lab in a Github repository.  As root, run the following command to download a series of installation scripts:

```
git clone https://github.com/patrocinio/openshift-install.git

cd openshift-install
```

## 2 - Install Ansible in the Ansible servers

*Do this procedure in the Ansible server*

[Ansible](https://www.ansible.com/) is an automation tool used to perform shell commands in parallel across a set of hosts.  Our lab uses Ansible extensively to perform actions from a single host to make things easier.  As root, run the following command to install Ansible.

```
./install_ansible.sh
```


## 3 - Copy SSH key to all servers

*Do this procedure in the Ansible server*

In order for Ansible to connect to all of the hosts, passwordless SSH must be set up between all of the nodes in the Openshift cluster.  As root, run the following command to generate an SSH key and copy the public key to all of the other servers:

```
./copy_ssh_key.sh
```

This script is interactive and requires pressing Enters and typing passwords a few times.  The password is `thinkibm`.

## 4 - Test connectivity to all hosts

*Do this procedure in the Ansible server*

Test if the previous two steps were successful by executing the Ansible [ping](https://docs.ansible.com/ansible/latest/modules/ping_module.html) module across all of the hosts.  As root, run the following command to check whether the ansible server can communicate with the other servers:

```
./ping.sh
```

You should see the following output:

```
[root@os-ansible openshift-install]# ./ping.sh
os-master1.mooo.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
os-node2.mooo.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
os-infra1.mooo.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
os-node1.mooo.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}

```


## 5 - Install pre-requisites

*Do this procedure in the Ansible server*

Before installing Openshift, we have prepared a script that uses Ansible to update and install some packages in parallel, including `docker`.  If you are curious, you can have a look inside this script to see what are installed.  

As root, run the following command to install the required packages on the following servers:
* Infra-1
* Master-1
* Node-1
* Node-2

```
./install_packages.sh
```

## 6 - Define Docker Storage

*Do this procedure in the Ansible server*

Red Hat recommends using the `devicemapper` storage driver with Docker and storing Docker container images in a thin-provisioned logical volume in a separate block device.  This script prepares the block devices we have included for docker storage on each cluster node.  

As root, run the following command to configure Docker storage on the following servers:

* Infra-1
* Master-1
* Node-1
* Node-2

```
./define_docker_storage.sh
```

*NOTE: you may see some errors during this step.  The VMs in the cluster already have Docker installed and configured, so you can disregard the error messages.*

## 7 - Configure etcd storage

*Do this procedure in the Ansible server*

We now need to configure a separate disk for etcd storage in the master node. Run the following script to configure the storage:

```
./set_up_volumes_etcd.sh
```

Now, run the following script to check the result:

```
./check_result_etcd.sh
```

You should something similar see the following output, observe that `sdb` is used in an `lvm` thinpool volume, and `sdc` is now a `lvm` volume that has been mounted at `/var/lib/etcd`.

```
[root@os-ansible openshift-install]# ./check_result_etcd.sh
os-master1.mooo.com | SUCCESS | rc=0 >>
NAME                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0                                 2:0    1    4K  0 disk
sda                                 8:0    0   30G  0 disk
├─sda1                              8:1    0    1G  0 part /boot
└─sda2                              8:2    0   29G  0 part
  ├─cl-root                       253:0    0   26G  0 lvm  /
  └─cl-swap                       253:1    0    3G  0 lvm  [SWAP]
sdb                                 8:16   0   10G  0 disk
└─sdb1                              8:17   0   10G  0 part
  ├─docker--vg-docker--pool_tmeta 253:2    0   12M  0 lvm  
  │ └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
  └─docker--vg-docker--pool_tdata 253:3    0    4G  0 lvm  
    └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
sdc                                 8:32   0   10G  0 disk
└─etcd--vg-etcd--lv               253:5    0   10G  0 lvm  /var/lib/etcd
sr0                                11:0    1 1024M  0 rom  

```

## 8 - Configure storage in the other nodes

*Do this procedure in the Ansible server*

Similarly, we need to configure the storage in the infra and worker nodes. Run the following script:

```
./set_up_volumes_other_nodes.sh
```

Run the following script to check the result:

```
./check_result_other_nodes.sh
```

You should something similar see the following output, observe that `sdb` is used in an `lvm` thinpool volume, and `sdc` is now a `lvm` volume that has been mounted at `/var/lib/origin`.

```
[root@os-ansible openshift-install]# ./check_result_other_nodes.sh
os-infra1.mooo.com | SUCCESS | rc=0 >>
NAME                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0                                 2:0    1    4K  0 disk
sda                                 8:0    0   30G  0 disk
├─sda1                              8:1    0    1G  0 part /boot
└─sda2                              8:2    0   29G  0 part
  ├─cl-root                       253:0    0   26G  0 lvm  /
  └─cl-swap                       253:1    0    3G  0 lvm  [SWAP]
sdb                                 8:16   0   10G  0 disk
└─sdb1                              8:17   0   10G  0 part
  ├─docker--vg-docker--pool_tmeta 253:2    0   12M  0 lvm  
  │ └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
  └─docker--vg-docker--pool_tdata 253:3    0    4G  0 lvm  
    └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
sdc                                 8:32   0   10G  0 disk
└─origin--vg-origin--lv           253:5    0   10G  0 lvm  /var/lib/origin
sr0                                11:0    1 1024M  0 rom  

os-node2.mooo.com | SUCCESS | rc=0 >>
NAME                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0                                 2:0    1    4K  0 disk
sda                                 8:0    0   30G  0 disk
├─sda1                              8:1    0    1G  0 part /boot
└─sda2                              8:2    0   29G  0 part
  ├─cl-root                       253:0    0   26G  0 lvm  /
  └─cl-swap                       253:1    0    3G  0 lvm  [SWAP]
sdb                                 8:16   0   10G  0 disk
└─sdb1                              8:17   0   10G  0 part
  ├─docker--vg-docker--pool_tmeta 253:2    0   12M  0 lvm  
  │ └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
  └─docker--vg-docker--pool_tdata 253:3    0    4G  0 lvm  
    └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
sdc                                 8:32   0   10G  0 disk
└─origin--vg-origin--lv           253:5    0   10G  0 lvm  /var/lib/origin
sr0                                11:0    1 1024M  0 rom  

os-node1.mooo.com | SUCCESS | rc=0 >>
NAME                              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0                                 2:0    1    4K  0 disk
sda                                 8:0    0   30G  0 disk
├─sda1                              8:1    0    1G  0 part /boot
└─sda2                              8:2    0   29G  0 part
  ├─cl-root                       253:0    0   26G  0 lvm  /
  └─cl-swap                       253:1    0    3G  0 lvm  [SWAP]
sdb                                 8:16   0   10G  0 disk
└─sdb1                              8:17   0   10G  0 part
  ├─docker--vg-docker--pool_tmeta 253:2    0   12M  0 lvm  
  │ └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
  └─docker--vg-docker--pool_tdata 253:3    0    4G  0 lvm  
    └─docker--vg-docker--pool     253:4    0    4G  0 lvm  
sdc                                 8:32   0   10G  0 disk
└─origin--vg-origin--lv           253:5    0   10G  0 lvm  /var/lib/origin
sr0                                11:0    1 1024M  0 rom  
```

We are almost there. Hang in tight!

## 9 - Download the OpenShift ansible playbooks

*Do this procedure in the Ansible server*

Finally, we are ready to download the Openshift installation scripts.  These are shipped as Ansible playbooks, which are groups of commands that are run together to perform a particular operation. We will be using the [OKD](https://www.okd.io/) 3.11 installation scripts hosted on [Github](https://github.com/openshift/openshift-ansible.git).  OKD (formerly Openshift Origin) is the community edition of OpenShift that is functionally the same as the OpenShift Enterprise distribution. As root, run the following command to download the Ansible playbooks:

```
./download_playbooks.sh
```

## 10 - Install pre-requisites

*Do this procedure in the Ansible server*

Before running the full OpenShift installation, review the [openshift_inventory](https://github.com/patrocinio/openshift-install/blob/master/openshift_inventory) file.  We have pre-populated this file with the hostnames in the cluster and the options that will work well with the size of VMs we have prepared in the Skytap environment.  You can take a look at more sample inventory files [here](https://docs.openshift.com/container-platform/3.11/install/example_inventories.html) or look at all the possible options [here](https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html).  

We will now execute the `prerequisites` playbook.

```
./prereqs.sh
```

You should see the following output at the end:

```
PLAY RECAP *********************************************************************
localhost                  : ok=11   changed=0    unreachable=0    failed=0   
os-infra1.mooo.com         : ok=54   changed=18   unreachable=0    failed=0   
os-master1.mooo.com        : ok=79   changed=19   unreachable=0    failed=0   
os-node1.mooo.com          : ok=54   changed=18   unreachable=0    failed=0   
os-node2.mooo.com          : ok=54   changed=18   unreachable=0    failed=0   


INSTALLER STATUS ***************************************************************
Initialization  : Complete (0:00:53)
```

## 11 - Install OpenShift

*Do this procedure in the Ansible server*

Finally, we are now ready to install OpenShift.  This step will pull all of the Openshift Origin images from [Docker Hub](https://hub.docker.com/), generate configuration for the cluster, and start the platform.  Run the following script:

```
./deploy_cluster.sh
```

This script can take over 30 minutes, so go for a coffee (or tea).

You should see the following message at the end:

```
PLAY RECAP *********************************************************************
localhost                  : ok=11   changed=0    unreachable=0    failed=0   
os-infra1.mooo.com         : ok=54   changed=18   unreachable=0    failed=0   
os-master1.mooo.com        : ok=79   changed=19   unreachable=0    failed=0   
os-node1.mooo.com          : ok=54   changed=18   unreachable=0    failed=0   
os-node2.mooo.com          : ok=54   changed=18   unreachable=0    failed=0   


INSTALLER STATUS ***************************************************************
Initialization  : Complete (0:00:53)
```

## 12 - Check OpenShift Installation - Ansible

*Do this procedure in the Ansible server*

We can now test the OpenShift installation from the command line.

Install the `oc` and `kubectl` CLI which is used to talk to the OpenShift control plane running on the master node.

```bash
./validate.sh
```

We have created a user, `user1`, as a regular OpenShift user.  Log in to the Openshift CLI as `user1` using the password `password`.

```bash
oc login https://console.10.0.0.2.mooo.com:8443
```

You will see a warning about insecure connections, since we generated self-signed certificates during installation. You can bypass the certificate checks.

```
The server uses a certificate signed by an unknown authority.
You can bypass the certificate check, but any data you send to the server could be intercepted by others.
Use insecure connections? (y/n): y

Authentication required for https://console.10.0.0.2.mooo.com:8443 (openshift)
Username: user1
Password:
Login successful.
```

## 13 - Check OpenShift Installation - Master Host

*Do this procedure in the Openshift Master server*

As *root*, run the following commands to log in to the OpenShift installation as the local administrative user:

```
oc login -u system:admin -n default
```

You will see the following output:

```
[root@os-master1 openshift-install]# oc login -u system:admin -n default
Logged into "https://os-master1.mooo.com:8443" as "system:admin" using existing credentials.

You have access to the following projects and can switch between them with 'oc project <projectname>':

  * default
    kube-public
    kube-service-catalog
    kube-system
    management-infra
    openshift
    openshift-console
    openshift-infra
    openshift-logging
    openshift-monitoring
    openshift-node
    openshift-sdn
    openshift-template-service-broker
    openshift-web-console

Using project "default".
```

Run the following command to view all the nodes in the cluster:

```
oc get nodes
```

and you should see the following output:

```
[root@os-master1 openshift-install]# oc get nodes
NAME                  STATUS    ROLES     AGE       VERSION
os-infra1.mooo.com    Ready     infra     1d        v1.11.0+d4cacc0
os-master1.mooo.com   Ready     master    1d        v1.11.0+d4cacc0
os-node1.mooo.com     Ready     compute   1d        v1.11.0+d4cacc0
os-node2.mooo.com     Ready     compute   1d        v1.11.0+d4cacc0
```

Run the following command, which shows all of the services in the `default` namespace:

```
oc get svc
```

You will see the following output; these are the load-balanced service available in the `default` namespace.  Note that the Kubernetes API itself is available from inside the cluster at the name `kubernetes`.

```
[root@os-master1 openshift-install]# oc get svc
NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                   AGE
docker-registry    ClusterIP   172.30.71.41     <none>        5000/TCP                  1d
kubernetes         ClusterIP   172.30.0.1       <none>        443/TCP,53/UDP,53/TCP     1d
registry-console   ClusterIP   172.30.136.81    <none>        9000/TCP                  1d
router             ClusterIP   172.30.133.194   <none>        80/TCP,443/TCP,1936/TCP   1d
```

Assign the `cluster-admin` role to the `admin` user.  This assigns super-user permissions to this user allowing it to perform any operation.  For more information on role-based access control in Openshift, view the [documentation](https://docs.openshift.com/container-platform/3.11/admin_guide/manage_rbac.html)

```bash
oc create clusterrolebinding cluster-administrator --clusterrole=cluster-admin --user=admin
```

The output is similar to:

```
clusterrolebinding.rbac.authorization.k8s.io/cluster-administrator created
```

## 14 - Check OpenShift Web Console

*Do this procedure in the Openshift Master server*

Now, let's check OpenShift.

Open Firefox and point to

``
https://console.10.0.0.2.mooo.com:8443
``

We have created a DNS name in a free DNS provider to point this at the Openshift Console running on the master host.  After accepting the insecure connection, log in using:

```
user: admin
password: password
```

You will see the Web Console:

![Web Console](./images/WebConsole.png)

In the top left corner, there are two other consoles available including the _Application Console_ which provides a view of the applications running in the cluster and _Cluster Console_ which gives an ops-focused view of cluster infrastructure.  Note that the _Cluster Console_ points you at a separate domain because it runs as an app running on top of Openshift, which we have configured a wildcard DNS for at `*.apps.violet.cloudns.cx`.

## 14 - Create shared directories in the NFS Server

*Do this procedure in the Ansible server*

As root, run the following script to configure the NFS service in the NFS server.  This will create a `/registry` directory and export it as an NFS mount.  Since the SSH key was not sent to the NFS server in the previous step, it will ask for the root password for the NFS server again (the password is `thinkibm`).

```
./configure_nfs_server.sh
```

## 15 - Create Persistent Volumes

*Do this procedure in the Ansible server*

As root, run the following script to create the Persistent Volume. This will use ansible to copy the file `nfs-pv.yaml` to the master host which is used to create a persistent volume `registry-pv` and that can be used requested later by containers to store state.

```
./create_storage.sh
```

You will see similar to the following output, which indicates that the persistent volume is ready for use:

```
os-master1.mooo.com | CHANGED | rc=0 >>
NAME          CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
registry-pv   5Gi        RWO            Retain           Available                                      1s
```

A developer may now create a `PersistentVolumeClaim` object to request storage.  To demonstrate this, as `user1` we create a project which represents the developer workspace:

```bash
oc new-project test-pvc
```

To create the claim, run the following command to create a request.  The system will bind the request with the available volume.

```
oc create -f ./nfs-claim.yaml
```

You will see output similar to:

```
persistentvolumeclaim/nfs-claim1 created
```

Now run the following commands to check the resources:

```
oc get pvc
```

You should see the following result.  `Bound` indicates that the claim has been bound to the volume, `registry-pv`, that we created in the earlier step.

```
NAME         STATUS    VOLUME        CAPACITY   ACCESS MODES   STORAGECLASS   AGE
nfs-claim1   Bound     registry-pv   5Gi        RWO                           56s
```

## Congratulations!!

You just finished the installation and configuration of OpenShift!
