#
# @summary Plan to provision a Virtual Machine in different cloud providers (GCP, AWS & Azure)
#
# @param provider
#   The cloud provider to use for provisioning
#
# @param resource_name
#   The name of the resource to be provisioned, the same will be use to manage the state of the infrastructure.
#   So the preference is to use the unit name for the provisioned infrastructure
#
# @param instance_size
#   The instance size to be provisioned, the module will translate the instance size to the cloud provider specific
#   instance type depending on the provider.
#
# @param image
#   The cloud image that is used for new instance provisioning, the format of image varies
#   depending on provider
#   AWS : For AWS, the image name pattern can include both with and without an account ID prefix.
#     For example, without the account ID prefix, it can be "AlmaLinux OS 8.8*," and 
#     with the account ID prefix, it can be "764336703387/AlmaLinux OS 8.8*."
#
# @param region
#   Which region to provision infrastructure in, if not provided default will
#   be determined by provider
#
# @param subnet
#   Name or ID of an existing subnet to attach newly provisioned VMs to
#
# @param security_group_ids
#   The list of security groups which will be attached to the newly provisioned VMs
#
# @param tags
#   The list of tags to be attached to the newly provisioned VMs
#
# @param node_count
#   The number of instance/VMs to be provisioned in the given cloud provider
#   User can provision mininum of 1 instance and maximum of 10 instances at a time.
#
# @param provider_options
#   The list of cloud provider options to be passed to the provisioning module
#   Eg: 
#     For instance, when configuring options for AWS, you can include the following settings:
#     {
#       "profile": "default",                   # AWS profile name
#       "ssh_key_name": "ssh_key_name",         # The SSH key-pair name for provisioning the instance.
#       "root_block_device_volume_type": "gp3", # The type of the root block device.
#       "root_block_device_volume_size": 10,     # The volume size of the root block device in GB.
#       "associate_public_ip_address": true             # Associate a public IP address to provisioned instance.
#     }
#
#     These settings allow you to customize the provisioning process based on cloud provider and specific requirements.
#   Eg:
#     For instance, when configuring options for GCP, you can include the following settings:
#     {
#       "root_block_device_volume_type": "pd-ssd", # Boot Disk Type.
#       "root_block_device_volume_size": 10     # Boot Disk Size.
#       "network": "<network-name-on-gcp>"
#       "subnetwork": "<subnetwork-name-on-gcp>"
#       "subnetwork_project": "<subnetwork-project-on-gcp>"
#     }
#   
# @param pe_server
#   The The PE server to be used for pointing the VM's puppet agent to
#
# @param environment
#   The puppet environment to place the agent in
#
# @param os_type
#   The type of operating system (linux or windows) to be used for provisioning the VMs
#
plan provision::create(
  Optional[String[1]] $subnet = undef,
  Optional[Array[String[1]]] $security_group_ids = undef,
  Optional[String[1]] $image                     = undef,
  String[1] $resource_name                       = 'provision',
  Provision::CloudProvider $provider             = 'aws',
  Provision::InstanceType $instance_size         = 'micro',
  Provision::HardwareArchitecture $hardware_architecture = 'amd',
  String[1] $region                              = 'us-west-2',
  Optional[Integer[1, 10]] $node_count           = 1,
  Optional[Hash[String[1], String[1]]] $tags     = {},
  Optional[String[1]] $pe_server                 = undef,
  Optional[String[1]] $environment               = 'production',
  Optional[Enum['linux', 'windows']] $os_type    = 'linux',
  Optional[Provision::ProviderOptions] $provider_options = undef,

  ##GCP Specific Parameters
  Optional[String[1]] $project                    = undef,
) {
  out::message('Starting infrastructure provisioning')
  $tf_dir = "terraform/${provider}/"

  $_resource_name = "${resource_name}-${Timestamp.new().strftime('%Y%m%d%H%M%S')}"

  $result = run_plan('provision::terraform::apply', {
      tf_dir                 => $tf_dir,
      provider               => $provider,
      hardware_architecture  => $hardware_architecture,
      resource_name          => $_resource_name,
      instance_size          => $instance_size,
      image                  => $image,
      region                 => $region,
      node_count             => $node_count,
      subnet                 => $subnet,
      security_group_ids     => $security_group_ids,
      tags                   => $tags,
      provider_options       => $provider_options,
      environment            => $environment,
      pe_server              => $pe_server,
      os_type                => $os_type,
      project                => $project,
  })

  out::message("Completed infrastructure provisioning with ${node_count} servers")
}
