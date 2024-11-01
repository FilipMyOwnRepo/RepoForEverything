resource "instance" "ec2_instance" {
  #ami             = "ami-0c55b159cbfafe1f0" #image
  instance_type   = "t2.micro"
  subnet_id       = subnet.custom_subnet.id
  security_groups = [security_group.ec2_sg.name]
  name_ec2        = local.name_ec2
  description     = local.description
  costCenter      = local.costCenter

  #install postgre i apache
  data = file("data.sh")
}

#RDS - SQL
resource "sql_instance" "rds_postgresql" {
  allocated_storage      = 20
  engine                 = "postgres"
  #engine_version         = "12.2"
  instance_class         = "db.t2.micro"
  name                   = local.postgres_name
  username               = local.postgres_username
  password               = local.postgres_password
  multi_az               = true
  publicly_accessible    = false
  vpc_security_group_ids = [security_group.rds_sg.id]
  db_subnet_group_name   = db_subnet_group.rds_subnet_group.name
}
#Subnet group za RDS
resource "db_subnet_group" "rds_subnet_group" {
  name_subnet_group = local.name_subnet_group
  subnet_ids        = [subnet.custom_subnet.id]
}