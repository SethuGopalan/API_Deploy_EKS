data "aws_eks_cluster" "cluster" {

  name = aws_eks_cluster.population_cluster.name
}



data "aws_eks_cluster_auth" "mycluster" {

  name = aws_eks_cluster.population_cluster.name
}

