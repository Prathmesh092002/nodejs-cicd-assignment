This project demonstrates a production-ready CI/CD and AWS infrastructure setup.
GitHub Actions handles CI with lint, test, and build stages.
AWS infrastructure is provisioned using Terraform with VPC, ALB, and Auto Scaling.
The application is deployed on EC2 instances behind an Application Load Balancer.
High availability is achieved using multi-AZ subnets and health checks.
To deploy, configure AWS credentials and run `terraform init && terraform apply