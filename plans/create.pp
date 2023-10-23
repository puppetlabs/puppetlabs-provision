#
# @summary Plan to provision a Virtual Machine in different cloud providers (GCP, AWS & Azure)
#
# @param provider
#   The cloud provider to be provisioned
#
# @param resource_name
#   The name of the resource to be provisioned
#
# @param instance_type
#   The instance type to be provisioned
#
# @param image
#   The cloud image that is used for new instance provisioning, format differs
#   depending on provider
#
# @param region
#   Which region to provision infrastructure in, if not provided default will
#   be determined by provider
#
# @param ssh_key
#   The SSH key name to be provisioned & access the machine
#
# @param ssh_user
#   The ssh user to provision on provisioned VMs
#
# @param subnet
#   Name or ID of an existing subnet to attach newly provisioned VMs
#
# @param security_group_ids
#   The list of security group which will be attached to the newly provisioned VMs
#
# @param backend
#   The backend to be provisioned
#
# @param bucket
#   The bucket to be provisioned
#
# @param profile
#   The name of the profile to be used for provisioning
#
# @param tags
#  The list of tags to be attached to the newly provisioned VMs
#
plan provision::create(
  String[1] $resource_name                                           = 'puppetlabs-provision',
  Enum['gcp', 'aws', 'azure'] $provider                              = 'aws',
  Enum['xlarge', 'large', 'medium', 'small', 'micro'] $instance_type = 'micro',
  Enum['arm', 'amd', 'intel'] $architecture                          = 'intel',
  String[1] $image                                                   = undef,
  String[1] $region                                                  = undef,
  Integer $node_count                                                = 1,
  String[1] $subnet                                                  = undef,
  Array $security_group_ids                                          = undef,
  String[1] $profile                                                 = undef,
  String[1] $ssh_key                                                 = undef,
  String[1] $ssh_user                                                = undef,
  Optional[Hash] $tags                                               = {},
  # TODO : Infrastructure state management parames
  Optional[String] $backend                                          = undef,
  Optional[String] $bucket                                           = undef,
) {
  out::message('Starting infrastructure provisioning')
  $tf_dir = "terraform/${provider}/"

  $result = run_plan('provision::terraform::create', {
      tf_dir             => $tf_dir,
      provider           => $provider,
      architecture       => $architecture,
      resource_name      => $resource_name,
      instance_type      => $instance_type,
      image              => $image,
      region             => $region,
      node_count         => $node_count,
      subnet             => $subnet,
      security_group_ids => $security_group_ids,
      profile            => $profile,
      ssh_key            => $ssh_key,
      ssh_user           => $ssh_user,
      tags               => $tags,
      backend            => $backend,
      bucket             => $bucket,
  })

  out::message("Completed infrastructure provisioning with ${node_count} servers")

  return $result[0].value
}
