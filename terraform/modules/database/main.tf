resource "aws_db_subnet_group" "this" {
  name       = "nimbus-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "nimbus-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier             = "nimbus-dev-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "nimbus"
  username               = "admin"
  password               = "Password123!"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false

  tags = {
    Name = "nimbus-dev-db"
  }
}
