# 2i2c Organization-wide operations

Infrastructure for 2i2c-wide operations.

## What does this repo contain?

- List of projects we manage, with mappings to billing accounts (if we manage those too).
  Terraform code here creates the projects, ensures ownership in orgs & sets billing accounts.
- GCS bucket for [Terraform State](https://www.terraform.io/docs/language/state/index.html)
  of *all* 2i2c projects. We can use [GCS ACLs](https://cloud.google.com/storage/docs/access-control/lists)
  in the future if we want to grant non-2i2c-engineers access to particular 
  [terraform workspaces](https://www.terraform.io/docs/language/state/workspaces.html)
- List of user accounts to grant 'Owner' permissions on projects we manage. This is automatically
  done for projects under the 2i2c.org organization, but needs to be manually done for 
  other projects.

## Running Terraform

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
   read the proposed plan from terraform before applying it. We take precautions to prevent
   this from happening, but you should be careful regardless.

## How do I...?

### Create a new project, when I've a billing account?

Once the client organization provides us with a billing account,
we provision a project for them inside the 2i2c.org GCP organization.

1. Edit `projects.tfvars`, adding an entry to `fully_managed_projects`.
   The key should be the name of the project we want to create, and the
   value should be the billing account ID. Add a comment referencing more
   information about the client organization, ideally pointing to a GitHub
   issue.

2. Run terraform (with instructions specified above). This will give you a
   detaile plan on what exactly terraform will do. **Scrutinize this carefully** -
   only a new project should be created, nothing else should change. Particularly,
   there should be no **delete** actions.

3. Validate that the project has been created, and you have access to it with
   your user account. 

4. Commit the change, make a PR to the repo with it, and merge it. This is
   preferable to pushing to the repo directly. You can self-merge your PR.


