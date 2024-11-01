locals {
    name_vpc      = "custom-vpc"
    name_igw      = "custom-igw"
    public_subnet = "custom-public-subnet"
    router_table  = "public-route-table"
    sec_gr        = "ec2-sg"
    rds_sg        = "rds-sg"
    name_ec2      = "test-ec2"
    description   = "Test instance"
    costCenter    = "123456"
    sec_ec2       = "sec_ec2"
    #RDS
    postgres_identifier    = POSTGRES_IDENTIFIER
    postgres_name          = "postgre_sql"
    postgres_username      = "admin"
    postgres_password      = "password"
    postgres_instance_name = POSTGRES_DB_INSTANCE_NAME
    postgres_db_password   = POSTGRES_DB_PASSWORD
    postgres_port          = POSTGRES_PORT

    name_subnet_group = "rds-subnet-group"
}