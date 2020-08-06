#--- backend.tf
# Change the values to suit your remote backend TF state

terraform {
  backend "s3" {
    bucket                 = "tf-state-bucket-name"
    dynamodb_table         = "terraform-state-lock-dynamo"
    key                    = "terraform/terraform-bastion_demo.tfstate"
    region                 = "us-east-1"
  }
}