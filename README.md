# Flynn-Terraform

### Create a Flynn cluster using Terraform

This repository holds work-in-progress code for launching Flynn into Google Cloud using Terraform.
### Prepare
- Be sure you have the [Google Cloud SDK][1] `gcloud` CLI configured
- Define the number of Flynn hosts desired in `terraform.tfvars`
- (Optional) Set other variables as desired in `terraform.tfvars` - variable names are discoverable in `vars.tf`

### Use

1. Get [HashiCorp's Terraform][2]
1. Navigate to repository root
1. Run `terraform plan -out plan.tfplan`
1. Visually verify plan
1. Execute the plan using `terraform apply plan.tfplan`
1. As needed, refresh the plan with another cycle of steps 2-5
1. Delete the nodes by using `terraform destroy --force`

### Develop
- We're using regular gitflow, so branch and pull request as normal.

### Current Status

This launches instances and downloads/installs Flynn, but does not bootstrap the machines.

##### TODO
- Add discovery step
- Add bootstrap step
- Add outputs


[1]: https://cloud.google.com/sdk/downloads
[2]: https://www.terraform.io/downloads.html
