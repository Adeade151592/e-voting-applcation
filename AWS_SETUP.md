# AWS Setup for CI/CD Pipeline

## Required GitHub Secrets

Go to: https://github.com/Adeade151592/e-voting-applcation/settings/secrets/actions

Add these secrets:

### 1. AWS_ACCOUNT_ID
```
427613144745
```

### 2. AWS_ROLE_NAME
```
github-actions-role
```

### 3. AWS_REGION
```
us-east-1
```

## Quick Setup Commands

### Create IAM Role for GitHub Actions
```bash
aws iam create-role \
  --role-name github-actions-role \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::427613144745:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
            "token.actions.githubusercontent.com:sub": "repo:Adeade151592/e-voting-applcation:ref:refs/heads/main"
          }
        }
      }
    ]
  }'
```

### Attach ECR Policy
```bash
aws iam attach-role-policy \
  --role-name github-actions-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser
```

### Create ECR Repositories
```bash
aws ecr create-repository --repository-name vote --region us-east-1
aws ecr create-repository --repository-name result --region us-east-1  
aws ecr create-repository --repository-name worker --region us-east-1
```

## Alternative: Use Personal Access Keys

If you don't want to set up OIDC, add these secrets instead:

### AWS_ACCESS_KEY_ID
Your AWS access key

### AWS_SECRET_ACCESS_KEY  
Your AWS secret key

Then update the pipeline to use:
```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: ${{ env.AWS_REGION }}
```