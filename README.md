# Flynn-Terraform

### Create a Flynn cluster using Terraform

This repository holds work-in-progress code for launching Flynn into Google Cloud using Terraform.
### Prepare
- Be sure you have the [Google Cloud SDK][1] `gcloud` CLI configured
- Define the number of Flynn hosts desired in `terraform.tfvars`
- Get [HashiCorp's Terraform][2] 0.11.1
- Install [terraform-provider-flynn][3] per its instructions. n.b.: requires [golang][4] >1.7
- (Optional) Set other variables as desired in `terraform.tfvars` - variable names are discoverable in `vars.tf`

### Use

1. Navigate to `./clusters`
```
cd clusters
```
1. Copy `template` folder to a folder with your new cluster name and enter the folder:
```
cp template NEW-CLUSTER
cd NEW-CLUSTER
```
1. Amend `prefix = "NEW-CLUSTER"` in `backend.tf`. `test-cluster` and `other-cluster` are examples
1. Ensure settings in `terraform.tfvars` are correct for your cluster/project.
1. Use the "zone" from Google Cloud DNS in the `flynn_gce_zone` variable
1. Use the "name" from Google Cloud DNS in the `flynn_gce_name` variable.
  - Be sure to omit the trailing dot.
1. Initialize Terraform modules and storage: `terraform init`
```
terraform init
```
1. Generate a plan
```
terraform plan -out plan.tfplan
```
1. Visually verify plan
1. Execute the plan using
```
terraform apply plan.tfplan
```
1. As needed, refresh the plan with another cycle of steps 2-5
1. Delete the nodes by using
```
terraform destroy --force
```

### Develop
- We're using regular gitflow, so branch and pull request as normal.

### Current Status

This will go from zero to fully-built Flynn cluster in about 5 minutes.


[1]: https://cloud.google.com/sdk/downloads
[2]: https://www.terraform.io/downloads.html
[3]: https://github.com/benosman/terraform-provider-flynn
[4]: https://golang.org/dl/
