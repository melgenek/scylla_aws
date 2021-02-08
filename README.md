Scylla on EKS
---

The repo contains scripts that create a scylla cluster on EKS. 

Creating the cluster:
0) Create a file `cluster/terraform.tfvars` (see the `terraform.tfvars.example`). 
   Specify the cluster name, region, vpc id and the private vpc networks.
1) Create the cluster
```shell
make create_cluster
```
2) (this step will be automated) Create the daemonset that mounts the instance store to the ec2 instances:
```shell
kubectl --kubeconfig=cluster/kubeconfig_{cluster_name} apply -f node-setup.yaml
```

There will be an EKS cluster created with a single-az Scylla cluster with 2 nodes.

TODO
----

- [ ] [connecting to the scylla cluster from outside the cluster](https://github.com/scylladb/scylla-operator/issues/196)
- [ ] multi-az setup
- [ ] enable cpu pinning, node networking
- [ ] scylla monitoring
- [ ] running a cassandra stress test
- [ ] backup and restoring a new cluster from backup (scylla manager, [velero](https://docs.bitnami.com/tutorials/backup-restore-data-cassandra-kubernetes/), a cross-region standby node?)
- [ ] testing the failover capabilities: 1 node is removed, 2 nodes removed. Are ip addresses kept?
- [ ] what is the ["repair" operation](https://docs.scylladb.com/operating-scylla/procedures/maintenance/repair/#scylla-repair): is it needed, how to run it?
- [ ] how to upgrade the cluster
- [ ] scylla monitoring loki
- [ ] how Spark/Athena read from scylla? How to dump the current state into s3 in Parquet?
