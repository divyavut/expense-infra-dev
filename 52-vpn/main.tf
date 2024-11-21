resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("~/.ssh/openvpn.pub")
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami =                     "ami-015bde79b8dffa19b"
  key_name = aws_key_pair.openvpn.key_name
  name = local.resource_name
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id              = local.public_subnet_ids
 
  tags = {
        Name = local.resource_name
  }
}