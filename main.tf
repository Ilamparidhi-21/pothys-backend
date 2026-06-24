resource "aws_security_group" "bad_sg" {
name = "bad-security-group"

ingress {
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port   = 3389
to_port     = 3389
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_s3_bucket" "bad_bucket" {
bucket = "terrascan-demo-bad-bucket"
}

resource "aws_s3_bucket_public_access_block" "bad" {
bucket = aws_s3_bucket.bad_bucket.id

block_public_acls       = false
block_public_policy     = false
ignore_public_acls      = false
restrict_public_buckets = false
}

resource "aws_iam_policy" "admin_policy" {
name = "full-admin-policy"

policy = jsonencode({
Version = "2012-10-17"
Statement = [{
Effect   = "Allow"
Action   = "*"
Resource = "*"
}]
})
}

resource "aws_db_instance" "bad_rds" {
identifier          = "bad-rds"
engine              = "mysql"
instance_class      = "db.t3.micro"
allocated_storage   = 20
username            = "admin"
password            = "Password123!"
skip_final_snapshot = true

publicly_accessible = true

storage_encrypted = false
}

resource "aws_ebs_volume" "bad_ebs" {
availability_zone = "ap-south-1a"
size              = 10

encrypted = false
}

resource "aws_instance" "bad_ec2" {
ami           = "ami-12345678"
instance_type = "t2.micro"

monitoring = false

metadata_options {
http_endpoint = "enabled"
http_tokens   = "optional"
}

tags = {
Name = "insecure-instance"
}
}

resource "aws_cloudtrail" "bad_trail" {
name                          = "badtrail"
s3_bucket_name                = "fake-bucket"
include_global_service_events = false
is_multi_region_trail         = false
enable_logging                = false
}

resource "aws_kms_key" "bad_kms" {
description = "bad kms"

deletion_window_in_days = 7
}

resource "aws_elasticache_cluster" "bad_cache" {
cluster_id           = "bad-cache"
engine               = "redis"
node_type            = "cache.t3.micro"
num_cache_nodes      = 1
port                 = 6379
}

resource "aws_secretsmanager_secret" "bad_secret" {
name = "plain-secret"
}

resource "aws_secretsmanager_secret_version" "bad_secret_value" {
secret_id     = aws_secretsmanager_secret.bad_secret.id
secret_string = "password=admin123"
}
