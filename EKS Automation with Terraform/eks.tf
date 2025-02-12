module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-cluster"
  cluster_version = "1.25"

  vpc_id = aws_vpc.eks_vpc.id  

  subnet_ids = [  
    aws_subnet.public_subnet.id,
    aws_subnet.private_subnet.id
  ]

  eks_managed_node_groups = {
    eks_nodes = {
      name           = "eks-nodes"
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
      iam_role_arn   = aws_iam_role.worker_node_role.arn  # ✅ Now this exists
    }
  }

  tags = {
    Name = "eks-cluster"
  }
}
