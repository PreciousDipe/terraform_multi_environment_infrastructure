resource "aws_security_group" "app" {
  name_prefix = "${var.environment}-app-"
  description = "Allow inbound app traffic and controlled outbound"
  vpc_id      = var.vpc_id

  ingress {
    description = "App traffic"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_ingress_cidrs
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(var.tags, { Name = "${var.environment}-app-sg" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "${var.environment}-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.app.id]

  metadata_options {
    # IMDSv2 only
    http_tokens = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.tags, { Name = "${var.environment}-app" })
  }

  tags = merge(var.tags, { Name = "${var.environment}-app-lt" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  name_prefix         = "${var.environment}-app-"
  vpc_zone_identifier = var.subnet_ids
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = merge(var.tags, { Name = "${var.environment}-app" })

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}