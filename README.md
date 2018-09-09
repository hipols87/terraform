## Developments with Terraform

Dependent Repository https://github.com/hipols87/terraform-config.git

<ul>
<li>git clone https://github.com/hipols87/terraform.git</li>
<li>git clone https://github.com/hipols87/terraform-config.git</li>
</ul>

vim ~/.aws/credentials

[default]

aws_access_key_id = xxxxxxxxxxxxxxxxxx

aws_secret_access_key = yyyyyyyyyyyyyyyyyyyyyyyy  


-----------------------------------------------------------------------------------------------
Create s3 bucket for state file
-----------------------------------------------------------------------------------------------

cd terraform/s3_bucket

#### Plan

terraform plan -var-file="../../terraform-config/non-prod/dev-env/variables.tfvars" -out plan.out

#### Apply

terraform apply "plan.out"

#### Destroy

terraform destroy -var-file="../../terraform-config/non-prod/dev-env/variables.tfvars"


-----------------------------------------------------------------------------------------------
Create ec2 instance
-----------------------------------------------------------------------------------------------

Grab access key id and secret access key from step above and put in ~/.aws/credentials file

vim ~/.aws/credentials

[s3_state_profile]

aws_access_key_id = xxxxxxxxxxxxxxxxxx

aws_secret_access_key = yyyyyyyyyyyyyyyyyyyyyyyy

cd terraform/ec3_test

#### Init

terraform init

Initializing the backend...
bucket
  The name of the S3 bucket

  Enter a value: <name_your_s3_bucket>

key
  The path to the state file inside the bucket

  Enter a value: <path_to_state_file>

region
  The region of the S3 bucket.

  Enter a value: <region>

#### Plan

terraform plan -var-file="../../terraform-config/non-prod/dev-env/variables.tfvars" -out plan.out

#### Apply

terraform apply "plan.out"

#### Destroy

terraform destroy -var-file="../../terraform-config/non-prod/dev-env/variables.tfvars"