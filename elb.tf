locals {
  subnets_for_web_r1 = slice(module.vpc1.private_subnets, 0, 2)
  subnets_for_web_r2 = slice(module.vpc2.private_subnets, 0, 2)
}

resource "aws_lb" "elb_region1" {
  provider           = aws.region1
  depends_on         = [module.vpc1]
  name               = "elb-r1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_for_all_r1.id]
  subnets            = local.subnets_for_web_r1

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "elb-r1"
  }
}

resource "aws_lb_target_group" "r1-tg" {
  provider   = aws.region1
  depends_on = [module.vpc1]
  name       = "r1-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = module.vpc1.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "r1-tg-attach" {
  provider = aws.region1
  for_each = {
    for idx, subnet_id in local.subnets_for_web_r1 : idx => subnet_id
  }

  target_group_arn = aws_lb_target_group.r1-tg.arn
  target_id        = aws_instance.instance-r1[each.key].id
  port             = 80
  depends_on       = [aws_lb.elb_region1, aws_lb_target_group.r1-tg]
}


resource "aws_lb_listener" "listener-r1" {
  provider          = aws.region1
  load_balancer_arn = aws_lb.elb_region1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r1-tg.arn
  }
}


resource "aws_lb" "elb_region2" {
  provider           = aws.region2
  depends_on         = [module.vpc2]
  name               = "elb-r2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_for_all_r2.id]
  subnets            = local.subnets_for_web_r2

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "elb-r2"
  }
}

resource "aws_lb_target_group" "r2-tg" {
  provider   = aws.region2
  depends_on = [module.vpc2]
  name       = "r2-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = module.vpc2.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "r2-tg-attach" {
  provider = aws.region2
  for_each = {
    for idx, subnet_id in local.subnets_for_web_r2 : idx => subnet_id
  }

  target_group_arn = aws_lb_target_group.r2-tg.arn
  target_id        = aws_instance.instance-r2[each.key].id
  port             = 80
  depends_on       = [aws_lb.elb_region2, aws_lb_target_group.r2-tg]
}

resource "aws_lb_listener" "listener-r2" {
  provider          = aws.region2
  load_balancer_arn = aws_lb.elb_region2.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r2-tg.arn
  }
}