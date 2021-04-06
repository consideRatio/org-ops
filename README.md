# 2i2c Organization-wide operations

Infrastructure for 2i2c-wide operations.

## Setting up terraform

1. Install pre-requisites:
   - [Terraform](https://www.terraform.io/downloads.html)
   - [gcloud](https://cloud.google.com/sdk/docs/install)
2. [Authenticate with gcloud](https://cloud.google.com/sdk/docs/initializing)
   using your 2i2c.org email address. Use `two-eye-two-see-org` as project id.
   You need to be a member of the `gcp-billing-admins@2i2c.org` google group to
   be able to use this project.
3. Run `terraform init`.
4. Make changes you want, then apply them with `terraform apply -var-file projects.tfvars`.
   **BE VERY CAREFUL**, since you could potentially **DESTROY EVERYTHING**. So,
   read the proposed plan from terraform before applying it.