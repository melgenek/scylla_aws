data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

module "my-cluster" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = var.name
  cluster_version = "1.18"
  subnets = var.subnets

  vpc_id = var.vpc_id

  worker_groups = [
    {
      name = "Example"
      instance_type = "m5.large"
      asg_desired_capacity = 1
      asg_max_size = 1
      asg_min_size = 1
      root_volume_size = 100
      root_volume_type = "gp2"
      root_encrypted = true
      kubelet_extra_args = "--node-labels=pool=bla --cpu-manager-policy=static"
    },
    {
      name = "Scylla"
      instance_type = "m5.large"
      asg_desired_capacity = 2
      asg_max_size = 2
      asg_min_size = 2
      root_volume_size = 100
      root_volume_type = "gp2"
      root_encrypted = true
      additional_ebs_volumes = [
        {
          block_device_name = "/dev/sdf",
          volume_size = 100,
          volume_type = "gp2",
          encrypted = true
        }
      ]
      kubelet_extra_args = "--node-labels=pool=scylla-pool --register-with-taints=role=scylla-clusters:NoSchedule --cpu-manager-policy=static"
    },
    {
      name = "LoadTest"
      instance_type = "m5.large"
      asg_desired_capacity = 4
      asg_max_size = 4
      asg_min_size = 4
      root_volume_size = 30
      root_volume_type = "gp2"
      root_encrypted = true
      kubelet_extra_args = "--node-labels=pool=cassandra-stress-pool --register-with-taints=role=cassandra-stress:NoSchedule"
    },
    {
      name = "ScyllaMonitoring"
      instance_type = "m5.large"
      asg_desired_capacity = 1
      asg_max_size = 1
      asg_min_size = 1
      root_volume_size = 100
      root_volume_type = "gp2"
      root_encrypted = true
      kubelet_extra_args = "--node-labels=pool=monitoring-pool  --register-with-taints=role=cassandra-stress:NoSchedule"
    }
  ]
}
