resource "aws_db_instance" "default" {
  name                   = var.dbname
  engine                 = "mysql"
  option_group_name      = aws_db_option_group.default.name
  parameter_group_name   = aws_db_parameter_group.default.name
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  identifier              = "rds-${local.resource_prefix.value}"
  engine_version          = "8.0" # Latest major version 
  instance_class          = "db.t3.micro"
  allocated_storage       = "20"
  username                = "admin"
  password                = var.password
  apply_immediately       = true
  multi_az                = false
  backup_retention_period = 0
  storage_encrypted       = false
  skip_final_snapshot     = true
  monitoring_interval     = 0
  publicly_accessible     = true

  tags = {
    Name        = "${local.resource_prefix.value}-rds"
    Environment = local.resource_prefix.value
    yor_trace   = "a6322d23-bee6-4bcb-aa06-5228ea206b5d"
  }

  # Ignore password changes from tf plan diff
  lifecycle {
    ignore_changes = ["password"]
  }
}

resource "aws_db_option_group" "default" {
  engine_name              = "mysql"
  name                     = "og-${local.resource_prefix.value}"
  major_engine_version     = "8.0"
  option_group_description = "Terraform OG"

  tags = {
    Name        = "${local.resource_prefix.value}-og"
    Environment = local.resource_prefix.value
    yor_trace   = "3b809f47-3379-4514-9d69-3e9c26ce05f3"
  }
}

resource "aws_db_parameter_group" "default" {
  name        = "pg-${local.resource_prefix.value}"
  family      = "mysql8.0"
  description = "Terraform PG"

  parameter {
    name         = "character_set_client"
    value        = "utf8"
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_server"
    value        = "utf8"
    apply_method = "immediate"
  }

  tags = {
    Name        = "${local.resource_prefix.value}-pg"
    Environment = local.resource_prefix.value
    yor_trace   = "116997b8-7628-4668-820e-5402911f7018"
  }
}

resource "aws_db_subnet_group" "default" {
  name        = "sg-${local.resource_prefix.value}"
  subnet_ids  = ["${aws_subnet.web_subnet.id}", "${aws_subnet.web_subnet2.id}"]
  description = "Terraform DB Subnet Group"

  tags = {
    Name        = "sg-${local.resource_prefix.value}"
    Environment = local.resource_prefix.value
    yor_trace   = "a80973ae-75ba-4cb3-97cd-54a6a885f278"
  }
}

resource "aws_security_group" "default" {
  name   = "${local.resource_prefix.value}-rds-sg"
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name        = "${local.resource_prefix.value}-rds-sg"
    Environment = local.resource_prefix.value
    yor_trace   = "4dc68a93-35d9-4913-9c47-713ba3cec97e"
  }
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = "3306"
  to_port           = "3306"
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.web_vpc.cidr_block}"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.default.id}"
}
