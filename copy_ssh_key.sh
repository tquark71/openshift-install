ssh-keygen -t RSA

for host in os-master1 os-infra1 os-node1 os-node2
  echo Copying key to $host
  ssh-copy-id root@$host
end
