#### Developments with Terraform

Dependent Repository https://github.com/hipols87/terraform-config.git

<ul>
<li>git clone https://github.com/hipols87/terraform.git</li>
<li>git clone https://github.com/hipols87/terraform-config.git</li>
</ul>

vim ~/.aws/credentials
<[default]
aws_access_key_id = xxxxxxxxxxxxxxxxxx
aws_secret_access_key = yyyyyyyyyyyyyyyyyyyyyyyy>

cd terraform/s3_bucket

## Plan

terraform plan -var-file="../../terraform-config/non-prod/dev-env/variables.tfvars" -out plan.out

## Apply

terraform apply "plan.out"

## Destroy

terraform destroy -var-file="../../terraform-config/non-prod/dev-env/variables.tfvars"
