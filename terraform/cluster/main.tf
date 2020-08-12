#--- cluster/main.tf

resource "aws_iam_role" "sandbox_cluster" {
  name = "terraform-eks-sandbox-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "sandbox-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.sandbox_cluster.name
}

resource "aws_iam_role_policy_attachment" "sandbox-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.sandbox_cluster.name
}

resource "aws_security_group" "sandbox_cluster" {
  name        = "terraform-eks-sandbox-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-sandbox-cluster"
  }
}

resource "aws_security_group_rule" "sandbox-cluster-ingress-workstation-https" {
  cidr_blocks       = var.external_cidr
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sandbox_cluster.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "sandbox" {
  name     = var.cluster-name
  role_arn = aws_iam_role.sandbox_cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.sandbox_cluster.id]
    #subnet_ids         = aws_subnet.eks_subnet[*].id
    subnet_ids         = var.subnet_id
  }

  depends_on = [
    aws_iam_role_policy_attachment.sandbox-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.sandbox-cluster-AmazonEKSServicePolicy,
  ]
}
