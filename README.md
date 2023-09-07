# Project hierarchy

The project consists of few folders:

- app - python application source code and Dockerfile

- python-time-app-chart - helm chart for the app

- terraform - infrastructure code:
 * AWS networking (VPC, SGs, route tables, etc.)
 * AWS EKS cluster
 * AWS ECR
 * Helm chart for EKS controllers

# Provisioning

To provision infrastructure:

```
    $ cd terraform/environments/<env>/
    $ terraform apply
```
NOTE: supply `terraform/environments/<env>/locals.tf` and `terraform/environments/<env>/main.tf`
with your AWS account, region, etc. values

# Application deployment

To deploy the application to the cluster navigate to the project's root folder and run:
```
    $ helm install python-time-app simple-time-app-chart
```
