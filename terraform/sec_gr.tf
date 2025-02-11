resource "security_group" "ec2_sg" {
  vpc_id  = vpc.custom_vpc.id
  sec_ec2 = local.sec_ec2
}

#--------------- EC2
resource "vpc_security_group_ingress_rule" "ssh_ingress" {
  security_group_id = security_group.ec2_sg.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  cidr_blocks       = ["123.123.123.123/32"] 
}

resource "vpc_security_group_ingress_rule" "http_ingress" {
  security_group_id = security_group.ec2_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] 
}
resource "vpc_security_group_ingress_rule" "https_ingress" {
  security_group_id = security_group.ec2_sg.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] 
}
resource "vpc_security_group_egress_rule" "all_egress" {
  security_group_id = security_group.ec2_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1" #all
  cidr_blocks       = ["0.0.0.0/0"]
}

#---------------
resource "security_group" "rds_sg" {
  vpc_id = vpc.custom_vpc.id
  rds_sg = local.rds_sg
}
#ingress and egress
resource "vpc_security_group_ingress_rule" "rds_ingress" {
  security_group_id        = security_group.rds_sg.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = security_group.ec2_sg.id 
}

resource "vpc_security_group_egress_rule" "rds_egress" {
  security_group_id = security_group.rds_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1" #prstup ka EC2 po svim
  cidr_blocks       = ["0.0.0.0/0"]
}