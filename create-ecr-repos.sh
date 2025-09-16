#!/bin/bash

# Create ECR repositories for the e-voting app
echo "Creating ECR repositories..."

aws ecr create-repository --repository-name vote --region us-east-1 || echo "vote repo already exists"
aws ecr create-repository --repository-name result --region us-east-1 || echo "result repo already exists"  
aws ecr create-repository --repository-name worker --region us-east-1 || echo "worker repo already exists"

echo "ECR repositories created successfully!"
echo ""
echo "Repository URIs:"
echo "vote: 427613144745.dkr.ecr.us-east-1.amazonaws.com/vote"
echo "result: 427613144745.dkr.ecr.us-east-1.amazonaws.com/result"
echo "worker: 427613144745.dkr.ecr.us-east-1.amazonaws.com/worker"