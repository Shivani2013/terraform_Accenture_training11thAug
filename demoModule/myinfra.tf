module "AWS_Infra" {
cidr_block = "10.0.0.0/16"
source = "./aws1"
}

module "Azure_Infra" {
source = "./azure1"
}

