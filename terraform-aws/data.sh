#!/bin/bash
yum update -y
yum install -y httpd postgresql
systemctl start httpd
systemctl enable httpd