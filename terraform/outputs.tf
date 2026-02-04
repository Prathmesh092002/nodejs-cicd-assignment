output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}
output "backend_ec2_public_ip" {
  description = "Public IP of backend EC2 instance"
  value       = aws_instance.backend.public_ip
}
