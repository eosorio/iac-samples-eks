#--- root outputs.tf

output "config_map_aws_auth" {
  value = module.worker-nodes.config_map_aws_auth
}

output "kubeconfig" {
  value = module.cluster.kubeconfig
}
