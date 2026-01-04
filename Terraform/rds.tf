resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "db-subnet-group"
  }
}


resource "aws_db_instance" "app_db" {
  identifier        = "app-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name = "appdb"

  username = jsondecode(
    data.aws_secretsmanager_secret_version.db_secret.secret_string
  )["username"]

  password = jsondecode(
    data.aws_secretsmanager_secret_version.db_secret.secret_string
  )["password"]

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false
  multi_az            = false

  tags = {
    Name = "app-rds"
  }
}
