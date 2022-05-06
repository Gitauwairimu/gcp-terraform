Instructions for Use

# gcp-terraform

1. To use the code you must have access to GCP account, a downloaded key to which you point to in provider.tf.

2. The service account whose key is used must have all needed permisions.

3. Git pull into your local machine

4. Install terraform

5. Enter (cd) into the folder named for specific GCP product you desire to provision.

6. Ensure all configuration particularly in the provider.tf is accurate.

7. Into the commandline, enter "terraform init" to initialize the terraform and allow it download appropriate plugins

8. Do "terraform validate", "terraform plan" and then "terraform apply --auto-approve".

9. Do "terraform destroy --auto-approve" to remove all provisioned serviices as needed.

This assumes some knowledge of GCP and terraform.
This is work in progress
