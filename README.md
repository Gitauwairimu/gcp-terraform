# gcp-terraform

To use the code you must have access to GCP account, a downloaded key to which you point to in provider.tf.
The service account whose key is used must have all needed permisions.
Git pull into your local machine
Install terraform
Enter (cd) into the folder named for specific GCP product you desire to provision.
Ensure all configuration particularly in the provider.tf is accurate.
Into the commandline, enter "terraform init" to initialize the terraform and allow it download appropriate plugins
Do "terraform validate", "terraform plan" and then "terraform apply --auto-approve".
Do "terraform destroy --auto-approve" to remove all provisioned serviices as needed.

This assumes some knowledge of GCP and terraform.
This is work in progress
