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
#   The backend to manage the state of the Terraform project
#
# @param bucket
#   The bucket where tfstate will get maintained
#
# @param profile
#   The name of the profile to be used for provisioning
#
# @param tags
#  The list of tags to be attached to the newly provisioned VMs
#
plan provision::terraform::create(
  String[1] $tf_dir                    = undef,
  Enum['gcp', 'aws', 'azure'] $provider = 'aws',
  Enum['xlarge', 'large', 'medium', 'small', 'micro'] $instance_type = 'micro',
  Enum['arm', 'amd', 'intel'] $architecture                          = 'intel',
  String[1] $resource_name             = undef,
  String[1] $image                     = undef,
  String[1] $region                    = undef,
  Integer $node_count                  = 1,
  String[1] $subnet                    = undef,
  Array $security_group_ids            = [],
  String[1] $profile                   = undef,
  String[1] $ssh_key                   = undef,
  String[1] $ssh_user                  = undef,
  Optional[Hash] $tags                 = {},
  Optional[String[1]] $backend         = undef,
  Optional[String[1]] $bucket          = undef,
) {
  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  out::message('Initializing Terraform for provisioning')
  run_task('terraform::initialize', 'localhost', dir => $tf_dir)

  $_instance_type = provision::instance_type_mapping($provider, $instance_type, $architecture)
  # Constructs a tfvars file to be used by Terraform
  $tfvars = epp('provision/tfvars.epp', {
      resource_name          => $resource_name,
      user                   => $ssh_user,
      ssh_key                => $ssh_key,
      region                 => $region,
      node_count             => $node_count,
      image                  => $image,
      subnet                 => $subnet,
      profile                => $profile,
      security_group_ids     => $security_group_ids,
      instance_type          => $_instance_type,
      tags                   => $tags,
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
