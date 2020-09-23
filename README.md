# TerraGoat - Vulnerable Terraform Infrastructure

[![Maintained by Bridgecrew.io](https://img.shields.io/badge/maintained%20by-bridgecrew.io-blueviolet)](https://bridge.dev/2WBms5Q)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

TerraGoat is Bridgecrew's "Vulnerable by Design" Terraform repository.
![Terragoat](terragoat-logo.png)

TerraGoat is Bridgecrew's "Vulnerable by Design" Terraform repository.
TerraGoat is a learning and training project that demonstrates how common configuration errors can find their way into production cloud environments.

## Table of Contents

* [Introduction](#introduction)
* [Getting Started](#getting-started)
  * [AWS](#aws-setup)
  * [Azure](#azure-setup)
  * [GCP](#gcp-setup)
* [Contributing](#contributing)
* [Support](#support)

## Introduction

TerraGoat was built to enable DevSecOps design and implement a sustainable misconfiguration prevention strategy. It can be used to test a policy-as-code framework like [Checkov](https://github.com/bridgecrewio/checkov/), inline-linters, pre-commit hooks or other code scanning methods.

TerraGoat follows the tradition of existing *Goat projects that provide a baseline training ground to practice implementing secure development best practices for cloud infrastructure.

## Important notes

* **Where to get help:** the [Bridgecrew Community Slack](https://codified-security.herokuapp.com/)

Before you proceed please take a not of these warning:
> :warning: TerraGoat creates intentionally vulnerable AWS resources into your account. **DO NOT deploy TerraGoat in a production environment or alongside any sensitive AWS resources.**

## Requirements

* Terraform 0.12
* aws cli
* azure cli

To prevent vulnerable infrastructure from arriving to production see: [checkov](https://github.com/bridgecrewio/checkov/), the open source static analysis tool for infrastructure as code.

## Getting started

### AWS Setup

#### Installation (AWS)

You can deploy multiple TerraGoat stacks in a single AWS account using the parameter `TF_VAR_environment`.

#### Create an S3 Bucket backend to keep Terraform state

```bash
export TERRAGOAT_STATE_BUCKET="mydevsecops-bucket"
export TF_VAR_company_name=acme
export TF_VAR_environment=mydevsecops
export TF_VAR_region="us-west-2"

aws s3api create-bucket --bucket $TERRAGOAT_STATE_BUCKET \
    --region $TF_VAR_region --create-bucket-configuration LocationConstraint=$TF_VAR_region

# Enable versioning
aws s3api put-bucket-versioning --bucket $TERRAGOAT_STATE_BUCKET --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption --bucket $TERRAGOAT_STATE_BUCKET --server-side-encryption-configuration '{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms"
      }
    }
  ]
}'
```

#### Apply TerraGoat (AWS)

```bash
cd terraform/aws/
terraform init \
-backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
-backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
-backend-config="region=$TF_VAR_region"

terraform apply
```

#### Remove TerraGoat (AWS)

```bash
terraform destroy
```

#### Creating multiple TerraGoat AWS stacks

```bash
cd terraform/aws/
export TERRAGOAT_ENV=$TF_VAR_environment
export TERRAGOAT_STACKS_NUM=5
for i in $(seq 1 $TERRAGOAT_STACKS_NUM)
do
    export TF_VAR_environment=$TERRAGOAT_ENV$i
    terraform init \
    -backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
    -backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
    -backend-config="region=$TF_VAR_region"

    terraform apply -auto-approve
done
```

#### Deleting multiple TerraGoat stacks (AWS)

```bash
cd terraform/aws/
export TF_VAR_environment = $TERRAGOAT_ENV
for i in $(seq 1 $TERRAGOAT_STACKS_NUM)
do
    export TF_VAR_environment=$TERRAGOAT_ENV$i
    terraform init \
    -backend-config="bucket=$TERRAGOAT_STATE_BUCKET" \
    -backend-config="key=$TF_VAR_company_name-$TF_VAR_environment.tfstate" \
    -backend-config="region=$TF_VAR_region"

    terraform destroy -auto-approve
done
```

### Azure Setup

#### Installation (Azure)

You can deploy multiple TerraGoat stacks in a single Azure subscription using the parameter `TF_VAR_environment`.

#### Create an Azure Storage Account backend to keep Terraform state

```bash
export TERRAGOAT_RESOURCE_GROUP="TerraGoatRG"
export TERRAGOAT_STATE_STORAGE_ACCOUNT="mydevsecopssa"
export TERRAGOAT_STATE_CONTAINER="mydevsecops"
export TF_VAR_environment="dev"
export TF_VAR_region="westus"

# Create resource group
az group create --location $TF_VAR_region --name $TERRAGOAT_RESOURCE_GROUP

# Create storage account
az storage account create --name $TERRAGOAT_STATE_STORAGE_ACCOUNT --resource-group $TERRAGOAT_RESOURCE_GROUP --location $TF_VAR_region --sku Standard_LRS --kind StorageV2 --https-only true --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $TERRAGOAT_RESOURCE_GROUP --account-name $TERRAGOAT_STATE_STORAGE_ACCOUNT --query [0].value -o tsv)

# Create blob container
az storage container create --name $TERRAGOAT_STATE_CONTAINER --account-name $TERRAGOAT_STATE_STORAGE_ACCOUNT --account-key $ACCOUNT_KEY
```

#### Apply TerraGoat (Azure)

```bash
cd terraform/azure/
terraform init -reconfigure -backend-config="resource_group_name=$TERRAGOAT_RESOURCE_GROUP" \
    -backend-config "storage_account_name=$TERRAGOAT_STATE_STORAGE_ACCOUNT" \
    -backend-config="container_name=$TERRAGOAT_STATE_CONTAINER" \
    -backend-config "key=$TF_VAR_environment.terraform.tfstate"

terraform apply
```

#### Remove TerraGoat (Azure)

```bash
terraform destroy
```

### GCP Setup

#### Installation (GCP)

You can deploy multiple TerraGoat stacks in a single GCP project using the parameter `TF_VAR_environment`.

#### Create a GCS backend to keep Terraform state

To use terraform, a Service Account and matching set of credentials are required.
If they do not exist, they must be manually created for the relevant project.
To create the Service Account:
1. Sign into your GCP project, go to `IAM` > `Service Accounts`.
2. Click the `CREATE SERVICE ACCOUNT`.
3. Give a name to your service account (for example - `terragoat`) and click `CREATE`.
4. Grant the Service Account the `Project` > `Editor` role and click `CONTINUE`.
5. Click `DONE`.

To create the credentials:
1. Sign into your GCP project, go to `IAM` > `Service Accounts` and click on the relevant Service Account.
2. Click `ADD KEY` > `Create new key` > `JSON` and click `CREATE`. This will create a `.json` file and download it to your computer.

We recommend saving the key with a nicer name than the auto-generated one (i.e. `terragoat_credentials.json`), and storing the resulting JSON file inside `terraform/gcp` directory of terragoat.
Once the credentials are set up, create the BE configuration as follows:

```bash
export TF_VAR_environment="dev"
export TF_TERRAGOAT_STATE_BUCKET=remote-state-bucket-terragoat
export TF_VAR_credentials_path=<PATH_TO_CREDNETIALS_FILE> # example: export TF_VAR_credentials_path=terragoat_credentials.json
export TF_VAR_project=<YOUR_PROJECT_NAME_HERE>

# Create storage bucket
gsutil mb gs://${TF_TERRAGOAT_STATE_BUCKET}
```

#### Apply TerraGoat (GCP)

```bash
cd terraform/gcp/
terraform init -reconfigure -backend-config="bucket=$TF_TERRAGOAT_STATE_BUCKET" \
    -backend-config "credentials=$TF_VAR_credentials_path" \
    -backend-config "prefix=terragoat/${TF_VAR_environment}"

terraform apply
```

#### Remove TerraGoat (GCP)

```bash
terraform destroy
```

## Bridgecrew's IaC herd of goats

* [CfnGoat](https://github.com/bridgecrewio/cfngoat) - Vulnerable by design Cloudformation template
* [TerraGoat](https://github.com/bridgecrewio/terragoat) - Vulnerable by design Terraform stack

## Contributing

Contribution is welcomed!

We would love to hear about more ideas on how to find vulnerable infrastructure-as-code design patterns.

## Support

[Bridgecrew](https://bridge.dev/2WBms5Q) builds and maintains TerraGoat to encourage the adoption of policy-as-code.

If you need direct support you can contact us at [info@bridgecrew.io](mailto:info@bridgecrew.io).

## Existing vulnerabilities (Auto-Generated)
|    | check_id   | file           | resource                      | check_name                                                            | guideline                                                          |
|----|------------|----------------|-------------------------------|-----------------------------------------------------------------------|--------------------------------------------------------------------|
|  0 | CKV_AWS_19 | /aws/s3.tf     | aws_s3_bucket.data            | Ensure all data stored in the S3 bucket is securely encrypted at rest | https://docs.bridgecrew.io/docs/s3_14-data-encrypted-at-rest       |
|  1 | CKV_AWS_20 | /aws/s3.tf     | aws_s3_bucket.data            | S3 Bucket has an ACL defined which allows public READ access.         | https://docs.bridgecrew.io/docs/s3_1-acl-read-permissions-everyone |
|  2 | CKV_AWS_18 | /aws/s3.tf     | aws_s3_bucket.data            | Ensure the S3 bucket has access logging enabled                       | https://docs.bridgecrew.io/docs/s3_13-enable-logging               |
|  3 | CKV_AWS_52 | /aws/s3.tf     | aws_s3_bucket.data            | Ensure S3 bucket has MFA delete enabled                               |                                                                    |
|  4 | CKV_AWS_21 | /aws/s3.tf     | aws_s3_bucket.data            | Ensure all data stored in the S3 bucket have versioning enabled       | https://docs.bridgecrew.io/docs/s3_16-enable-versioning            |
|  5 | CKV_AWS_19 | /aws/s3.tf     | aws_s3_bucket.data_science    | Ensure all data stored in the S3 bucket is securely encrypted at rest | https://docs.bridgecrew.io/docs/s3_14-data-encrypted-at-rest       |
|  6 | CKV_AWS_52 | /aws/s3.tf     | aws_s3_bucket.data_science    | Ensure S3 bucket has MFA delete enabled                               |                                                                    |
|  7 | CKV_AWS_19 | /aws/s3.tf     | aws_s3_bucket.logs            | Ensure all data stored in the S3 bucket is securely encrypted at rest | https://docs.bridgecrew.io/docs/s3_14-data-encrypted-at-rest       |
|  8 | CKV_AWS_18 | /aws/s3.tf     | aws_s3_bucket.logs            | Ensure the S3 bucket has access logging enabled                       | https://docs.bridgecrew.io/docs/s3_13-enable-logging               |
|  9 | CKV_AWS_52 | /aws/s3.tf     | aws_s3_bucket.logs            | Ensure S3 bucket has MFA delete enabled                               |                                                                    |
| 10 | CKV_AWS_33 | /aws/ecr.tf    | aws_ecr_repository.repository | Ensure ECR image scanning on push is enabled                          | https://docs.bridgecrew.io/docs/general_8                          |
| 11 | CKV_AWS_51 | /aws/ecr.tf    | aws_ecr_repository.repository | Ensure ECR Image Tags are immutable                                   | https://docs.bridgecrew.io/docs/bc_aws_general_24                  |
| 12 | CKV_AWS_17 | /aws/db-app.tf | aws_db_instance.default       | Ensure all data stored in the RDS bucket is not public accessible     | https://docs.bridgecrew.io/docs/public_2                           |
| 13 | CKV_AWS_16 | /aws/db-app.tf | aws_db_instance.default       | Ensure all data stored in the RDS is securely encrypted at rest       | https://docs.bridgecrew.io/docs/general_4                          |
| 14 | CKV_AWS_24 | /aws/ec2.tf    | aws_security_group.web-node   | Ensure no security groups allow ingress from 0.0.0.0:0 to port 22     | https://docs.bridgecrew.io/docs/networking_1-port-security         |
| 15 | CKV_AWS_39 | /aws/eks.tf    | aws_eks_cluster.eks_cluster   | Ensure Amazon EKS public endpoint disabled                            | https://docs.bridgecrew.io/docs/bc_aws_kubernetes_2                |
| 16 | CKV_AWS_58 | /aws/eks.tf    | aws_eks_cluster.eks_cluster   | Ensure EKS Cluster has Secrets Encryption Enabled                     | https://docs.bridgecrew.io/docs/bc_aws_kubernetes_3                |
| 17 | CKV_AWS_38 | /aws/eks.tf    | aws_eks_cluster.eks_cluster   | Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0         | https://docs.bridgecrew.io/docs/bc_aws_kubernetes_1                |
| 18 | CKV_AWS_37 | /aws/eks.tf    | aws_eks_cluster.eks_cluster   | Ensure Amazon EKS control plane logging enabled for all log types     | https://docs.bridgecrew.io/docs/bc_aws_kubernetes_4                |


---


