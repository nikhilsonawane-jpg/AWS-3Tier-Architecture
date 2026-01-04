resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = aws_subnet.private[*].id
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.Ec2_lt.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.alb-tg.arn]

  tag {
    key                 = "Name"
    value               = "app-asg-instance"
    propagate_at_launch = true
  }

}
