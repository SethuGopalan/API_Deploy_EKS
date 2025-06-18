resource "aws_eks_cluster" "population_cluster" {

    name = "population-cluster "
    role_arn = aws_iam_role.eks_cluster_role.arn

    vpc_config {
         
         subnet_ids = [aws_subnet.eks_public.ids,
                       aws_subnet.eks_private.ids
          ]

    }
     endpoint_public_access = true
     endpoint_private_access = false



  
}
resource "aws_eks_node_group" "population_node_group" {

    cluster_name= aws_eks_cluster.population_cluster.name
    node_group_name= "population-node-group"
    node_role_arn = aws_iam_role.eks_node_role.arn
    subnet_ids = [aws_subnet.eks_public.id,
                  aws.subnet.eks_private.id
    ]

    scaling_config {
        desired_size = 2
        max_size =3
        min_size = 1

    }
    instence_types = [t3.small]

    tags = { 
        Name = population-node-group
        
        }
}