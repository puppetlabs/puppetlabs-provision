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
# @param instance_type
#   The instance type to be provisioned, the module will translate the instance type to the cloud provider specific
#   instance type depending on the provider.
#
# @param image
#   The cloud image that is used for new instance provisioning, format differs
#   depending on provider
#
# @param region
#   Which region to provision infrastructure in, if not provided default will
#   be determined by provider
#
# @param ssh_key_name
#   The SSH key name to be provisioned & access the machine.
#   The name of the SSH key which should already exist in the cloud and which will be used to access the provisioned instances.
#
# @param subnet
#   Name or ID of an existing subnet to attach newly provisioned VMs to
#
# @param security_group_ids
#   The list of security groups which will be attached to the newly provisioned VMs
#
# @param profile
#   The name of the profile to be used for provisioning
#
# @param tags
#  The list of tags to be attached to the newly provisioned VMs
#
# @param root_block_device_size
#   The volume size of the root block device in GB
#
# @param root_block_volume_type
#  The type of the root block device to attached to launched instance
#
# @param node_count
#   The number of instance/VMs to be provisioned in the given cloud provider
#
# @param associate_public_ip
#   Associate a public IP address with an instance in VPC/Network
#
plan provision::create(
  String[1] $resource_name                       = 'puppetlabs-provision',
  Provision::CloudProvider $provider             = 'aws',
  Provision::InstanceType $instance_size         = 'micro',
  Provision::HardwareArchitecture $hardware_architecture = 'amd',
  String[1] $region                              = 'us-west-2',
  Integer[10, 100] $root_block_device_size       = 10,
  String[1] $root_block_volume_type              = 'gp3',
  Optional[Boolean] $associate_public_ip         = false,
  String[1] $subnet                              = undef,
  Array[String[1]] $security_group_ids           = undef,
  Optional[String[1]] $profile                   = 'default',
  String[1] $ssh_key_name                        = undef,
  Optional[String[1]] $image                     = undef,
  Optional[Integer[1, 10]] $node_count           = 1,
  Optional[Hash[String[1], String[1]]] $tags     = {},
) {
  out::message('Starting infrastructure provisioning')
  $tf_dir = "terraform/${provider}/"

  $result = run_plan('provision::terraform::apply', {
      tf_dir                 => $tf_dir,
      provider               => $provider,
      hardware_architecture  => $hardware_architecture,
      resource_name          => $resource_name,
      instance_size          => $instance_size,
      image                  => $image,
      region                 => $region,
      node_count             => $node_count,
      subnet                 => $subnet,
      security_group_ids     => $security_group_ids,
      profile                => $profile,
      ssh_key_name           => $ssh_key_name,
      root_block_device_size => $root_block_device_size,
      root_block_volume_type => $root_block_volume_type,
      associate_public_ip    => $associate_public_ip,
      tags                   => $tags,
  })

  out::message("Completed infrastructure provisioning with ${node_count} servers")

  return $result[0].value
}
