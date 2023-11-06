# name                  = "poc-lab-test"
# node_count            = 1
# region                = "us-west-2"
# hardware_architecture = "amd"
# security_group_ids    = ["sg-09731612cf889f1b8"]
# subnet_id             = "subnet-0096d0de092f058d8"
# instance_size         = "micro"
# associate_public_ip_address = false
# tags = {
#     lifetime = "indefinite"
# }
# ssh_key_name = "puppetlabs_root_id_rsa"
# profile = "puppet-forge"

name   = "poc-lab-test"
region = "us-west-2"
# Required parameters which values are irrelevant on destroy
profile = "puppet-forge"
