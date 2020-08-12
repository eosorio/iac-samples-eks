#--- worker-nodes/main.tf

resource "aws_iam_role" "sandbox-node" {
  name = "terraform-eks-sandbox-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "sandbox-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.sandbox-node.name
}

resource "aws_iam_role_policy_attachment" "sandbox-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.sandbox-node.name
}

resource "aws_iam_role_policy_attachment" "sandbox-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.sandbox-node.name
}

resource "aws_eks_node_group" "sandbox" {
  cluster_name    = var.cluster-name
  node_group_name = "sandbox"
  node_role_arn   = aws_iam_role.sandbox-node.arn
  subnet_ids      = var.subnet_id

  scaling_config {
    desired_size = var.asg_capacity
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.sandbox-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.sandbox-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.sandbox-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

