# Build the app
```
    $ docker build -t time-app:v0.0.1 .
```
# Login to the AWS

```
    $ aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
```

NOTE: use your values for <account_id> and <region>

# Tag and push to the registry (which was provisioned by the Terraform)

```
    $ docker tag time-app:v0.0.1 <account_id>.dkr.ecr.<region>.amazonaws.com/time-app
    $ docker push <account_id>.dkr.ecr.<region>.amazonaws.com/private-registry/time-app
```
