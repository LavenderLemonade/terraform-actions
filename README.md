This is the project I'm using to learn GitHub Actions alongside Terraform!

I'm going to have a very simple AWS Infrastructure:

- A VPC with a *public* subnet
- An EC2 instance
- A security group that allows SSH access

From there I'm going to have the following set up to happen when GitHub Actions sees a push to main:

- Lint the code 
- Plan the Terraform changes
- Require manual approval