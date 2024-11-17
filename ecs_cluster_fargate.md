# Agenda

In this complete video we will be deploying 3 microservices on ECS cluster using Fargate options. We will explore all these items mentioned below.
Youtube Video Link : https://youtu.be/VOVEAI-Vw5c
## What is ECS Cluster
- Introduction to Amazon ECS (Elastic Container Service).
- Explanation of ECS Clusters and their role in managing containerized applications.

## Create ECS Cluster
- Step-by-step guide on creating an ECS Cluster using the AWS Management Console or AWS CLI.

## ECS Standalone Tasks on Fargate
- Explanation of standalone tasks in ECS.
- Overview of ECS Task execution IAM roles and their importance.
- Setting up ECS Security Groups for tasks.

## ECR (Elastic Container Registry)
- Introduction to Amazon ECR.
- How to create a repository and push Docker images to ECR.

## ECS Task Definition
- Explanation of ECS Task Definitions.
- How to create and configure a task definition.

## Run a Standalone Task
- Steps to run a standalone task using the ECS console or CLI.
- Demonstration of task execution and monitoring.

## Challenges with ECS Tasks and Review ECS Service
- Discussion of the limitations and challenges of using standalone tasks.
- Introduction to ECS Services and their benefits.

## Create an ECS Service
- Step-by-step guide on creating an ECS Service.
- Explanation of service configuration and deployment.

## Run Application
- Deploying an application using ECS Service.
- Monitoring and managing the running application.

## Create ECS Service using LoadBalancer
- Explanation of integrating ECS with a Load Balancer.
- Steps to create a target group, load balancer, and security group.

## Deploy the Application
- Deploying the application with the load balancer.
- Ensuring high availability and scalability.

## ECS Service Discovery
- Introduction to ECS Service Discovery.
- Deploying microservices and demonstrating how service discovery helps in connecting services.

# Module 1: Creating a New ECS Cluster

1. **Fargate**: Use Fargate to run containers without managing servers.
2. **CloudWatch Insight Monitoring**: Enable CloudWatch for monitoring and logging.
3. **KMS Keys**: Optionally, use KMS keys for encryption.
4. **Cost**: No cost to run the ECS cluster itself.

## Creating a Standalone Task
- **ECS Task IAM Role**: Assign an IAM role to the ECS task.
- **ECS Security Group**: Configure the security group for the task.
- **VPC**:
  - **Public Subnets**: Ensure the public subnet is attached to an internet gateway to pull the ECR image. If not, you may encounter errors like `CannotPullContainerError`.
  - **Public IP**: Enable assigning a public IP. If using a private IP, a NAT gateway is needed to access the image from ECR or Docker Hub.
- **ECR (Elastic Container Registry)**: A fully managed Docker container registry that makes it easy to store, manage, and deploy Docker container images.
- **Task Definition**: Go to the task definition section.
- **Create Task Definition**: Create a new task definition for the `hello-svc`.
- **CloudWatch**: Use CloudWatch for monitoring.

This is the simplest way to run any Docker image on ECS as a standalone task. If the container crashes, the application will be down. This feature is useful for running scheduled jobs as standalone tasks at defined intervals.

# Module 2: ECS Services

- **Replica**: ECS ensures your task is always running with the desired number of tasks.
  - **Rolling Update**: ECS starts a new task before stopping the existing one.
  - **Min Running Tasks**: Minimum number of tasks running during updates.
  - **Max Running Tasks**: Maximum number of tasks running during updates.

# Module 3: ALB & Listener Rules

- **Private Subnet**: Run your application inside a private subnet for security.
  - **Load Balancer**: Explore load balancer options.
  - **Port Mapping**: Ensure the task definition has at least one exposed port for the load balancer to route traffic.
  - **ALB (Application Load Balancer)**: Create an ALB.
  - **Target Group**: Create a target group.
  - **Listener Rules**: Use listener rules for path-based forwarding.
  - **hello and world service path based filter**
  - **internet facing**

# Module 4: Service Discovery and DNS

<img width="757" alt="image" src="https://github.com/user-attachments/assets/129ccb48-b830-45c9-b666-7181e2bdac4f">


In this example, we will explore how to deploy Java microservices using ECS Service Discovery.

## Requirements

### CloudMap
- **CloudMap**: Create a CloudMap for service discovery.
  - **What is CloudMap?**
    - AWS Cloud Map is a cloud resource discovery service. It allows you to define custom names for your application resources, and it maintains the updated location of these dynamically changing resources. This helps in service discovery and makes it easier to manage microservices.

### Service Discovery
- **Service Discovery**: Deploy multiple microservices and connect them using service discovery and DNS names.
  - Use AWS Cloud Map to register your services.
  - Configure ECS to use service discovery for your microservices.
  - Ensure that each service can be discovered using a DNS name.

### Architecture
- **Architecture**: Use internal DNS names to maintain consistent URLs across environments, reducing complexity.
  - Define internal DNS names for each service.
  - Use these DNS names in your application code to ensure consistency across different environments (development, staging, production).

## Microservices

### Hello Service
- **Hello Service**: Returns the message "hello from service".
  - Implement a simple Java service that responds with "hello from service".
  - Register this service with CloudMap.

### World Service
- **World Service**: Returns the message "world from service".
  - Implement a simple Java service that responds with "world from service".
  - Register this service with CloudMap.

### Client Service
- **Client Service**: Acts as a front-end service that communicates with both Hello and World services and presents the data to the end users.
  - Implement a Java service that:
    - Calls the Hello Service and retrieves the message.
    - Calls the World Service and retrieves the message.
    - Combines the messages and presents them to the end user.
  - Register this service with CloudMap.
  - Ensure that it uses the internal DNS names to communicate with Hello and World services.

