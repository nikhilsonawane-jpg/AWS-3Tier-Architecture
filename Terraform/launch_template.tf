resource "aws_launch_template" "Ec2_lt" {
  name          = "ec2_launch_template"
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.Ec2-sg.id]

  user_data = filebase64("userdata.sh")


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-ec2"
    }
  }
  tags = {
    Name = "Ec2_launch_template"
  }
}


