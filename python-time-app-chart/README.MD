# Build the app chart
```
    $ helm package python-time-app-chart
```
This will produce `python-time-app-chart-0.0.1.tgz` package in the repository root

# Login to the AWS

```
    $ aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
```

NOTE: use your values for <account_id> and <region>

# Push to the registry ( chart_repository_name provisioned by the Terraform)

```
    $ helm push python-time-app-chart-0.0.1.tgz oci://<account_id>.dkr.ecr.<region>.amazonaws.com/
```
NOTE: Chart repository name and chart name must be equal
