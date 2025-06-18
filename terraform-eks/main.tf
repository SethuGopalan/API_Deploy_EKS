resource "aws_vpc" "ec2_vpc" {

    cidr_blocks ="10.0.0.0/16"

    enable_dns_support = true
    enable_dns_hostnames = true
  
}



# if vpc already exists then

# resource "aws_vpc" "extsiting_vpc_name" {

#     filter={

#         name = "tag: Name" # serch by tag Name
#         value = [extsiting_vpc_name]  #value of the tag
#     }
  
# }

resource "aws_subnet" "eks_public" {

    vpc_id= aws_vpc.ec2_vpc.id
    cidr_blocks = "10.0.1.0/24"
    availability_zone = "us-east-1"
    map_public_ip_on_launch = true

    
 tags={
    Name="eks_public_subnet"
 }

      
}

resource "aws_subnet" "eks_private" {

    vpc_id = aws_vpc.ec2_vpc.id
    cidr_blocks = "10.0.2.0/24"
    availablity_zone = "us-east-1"
    map_public_ip_on_launch =false

    tags={name="eks_private_subnet"}
  
}
resource "aws_internet_Gateway" "igw" {

    vpc_id = aws_vpc.ec2_vpc.id

    tag={Name="main-IGW"}
  
}

resource "aws_route_table" "public_rt" {

    vpc_id = aws_vpc.ec2_vpc.id

    route{
        cidr_blocks ="0.0.0.0/0"
        igw_id =aws_internet_Gateway.igw.id
    }
     tag={Name = "public_rt"}
  
}
resource "aws_route_table_association" "public_association" {

    subnet_id = aws_subnet.eks_public.id
    routetable_id =aws_route_table.public_rt.id
  
}


resource "aws_security_group" "ec2_sec_grp" {

    name = "ec2_security_grp"

    description = "allow ssh and http"

    vpc_id= aws_vpc.ec2_vpc.id

    ingress {

        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =["10.0.0.0/16"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }
  
}

