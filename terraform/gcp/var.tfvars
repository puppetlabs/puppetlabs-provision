# project            = "ia-content"
# name               = "puppetlabs-provision"
# subnetwork_project = "ia-content"
# instance_size      = "small"
# region             = "us-west1"
# node_count         = 3
# image              = "debian-cloud/debian-11"
# tags               = {}
# profile            = "/Users/prajjwal.gupta/.config/gcloud/application_default_credentials.json"
# root_block_device_volume_size = 10
# root_block_device_volume_type = "pd-ssd"
# network = "default"
# subnetwork = "default"
# hardware_architecture = "amd"
# To test run the gcp , here is the profile
# bolt plan run provision::create --params @<FILENAME WITH JSON EXTENSION> -v
# {
#   "provider": "gcp",
#   "project": "ia-content",
#   "region": "us-west1",
#   "instance_size": "small",
#   "image": "debian-cloud/debian-11",
#   "node_count": 1,
#   "provider_options": {
#     "root_block_device_volume_type": "pd-ssd",
#     "root_block_device_volume_size": "10"
#   }
# }
# To destroy the provisioned gcp machine using bolt
# bolt plan run provision::destroy region=us-west1  provider=gcp project='ia-content'
