#
# @summary Plan to provision a Virtual Machine using Terraform for different cloud providers (GCP, AWS & Azure)
#
# @param tf_dir
#   The directory where the Terraform module is located
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
# @param ssh_key_name
#   The SSH key name to be used to provision the instance & once the instance gets provisioned
#   user will use this key to login to the instance.
#
# @param subnet
#   Name or ID of an existing subnet to attach newly provisioned VMs
#
# @param security_group_ids
#   The list of security group which will be attached to the newly provisioned VMs
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
plan provision::terraform::apply(
  String[1] $tf_dir                          = undef,
  Provision::CloudProvider $provider         = 'aws',
  Provision::InstanceType $instance_type     = 'micro',
  Provision::Architecture $architecture      = 'intel',
  String[1] $resource_name                   = undef,
  Optional[String[1]] $image                 = undef,
  String[1] $region                          = undef,
  Integer[1,10] $node_count                  = 1,
  String[1] $subnet                          = undef,
  Array[String[1]] $security_group_ids       = [],
  String[1] $profile                         = undef,
  String[1] $ssh_key_name                    = undef,
  Optional[Hash[String[1], String[1]]] $tags = {},
  Integer[10, 100] $root_block_device_size   = 10,
  String[1] $root_block_volume_type          = 'gp3',
  Optional[Boolean] $associate_public_ip     = false,
) {
  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  out::message('Initializing Terraform for provisioning')
  run_task('terraform::initialize', 'localhost', dir => $tf_dir)

  $_instance_type = provision::map_instance_type($provider, $instance_type, $architecture)
  # Constructs a tfvars file to be used by Terraform
  $tfvars = epp('provision/tfvars.epp', {
      resource_name          => $resource_name,
      ssh_key_name           => $ssh_key_name,
      region                 => $region,
      node_count             => $node_count,
      image_architecture     => provision::map_image_architecture($provider, $architecture),
      image                  => $image,
      subnet                 => $subnet,
      profile                => $profile,
      security_group_ids     => $security_group_ids,
      instance_type          => $_instance_type,
      tags                   => $tags,
      root_block_device_size => $root_block_device_size,
      root_block_volume_type => $root_block_volume_type,
      associate_public_ip    => $associate_public_ip,
  })

  out::message('Applying terraform plan to provison infrastructure')
  # Creating an on-disk tfvars file to be used by Terraform::Apply to avoid a
  # shell escaping issue
  #
  # with_tempfile_containing() custom function suggestion by Cas is brilliant
  # for this, works perfectly
  $tf_apply = provision::with_tempfile_containing('', $tfvars, '.tfvars') |$tfvars_file| {
    # Stands up our cloud infrastructure that we'll install PE onto, returning a
    # specific set of data via TF outputs that if replicated will make this plan
    # easily adaptable for use with multiple cloud providers
    run_plan('terraform::apply',
      dir           => $tf_dir,
      return_output => true,
      var_file      => $tfvars_file,
      state         => "${resource_name}.tfstate",
    )
  }
  $post_apply_opts = {
    'dir'   => $tf_dir,
    state   => "${resource_name}.tfstate",
  }

  $output = run_task('terraform::output', 'localhost', $post_apply_opts)
  return $output
}
