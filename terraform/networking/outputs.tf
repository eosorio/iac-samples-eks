#--- networking/outputs.tf

output "subnet_id" {
  value = aws_subnet.eks_subnet[*].id
}
