# This plan isn't shown in plan list output
# @api private
#
# @summary Plan to provision a Virtual Machine using Terraform for different cloud providers (GCP, AWS & Azure)
#
# @param tf_dir
#   The directory where the Terraform module is located
#
# @param resource_name
#   The name of the resource to be provisioned
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
#   Name or ID of an existing subnet to attach newly provisioned VMs
#
# @param security_group_ids
#   The list of security group which will be attached to the newly provisioned VMs
#
# @param tags
#  The list of tags to be attached to the newly provisioned VMs
#
# @param node_count
#   The number of instance/VMs to be provisioned in the given cloud provider.
#   User can provision mininum of 1 instance and maximum of 10 instances at a time.
#
# @param provider_options
#   The list of cloud provider options to be passed to the provisioning module
#   Eg: 
#     For instance, when configuring options for AWS, you can include the following settings:
#     {
#       "profile": "default",                   # AWS profile name
#       "ssh_key_name": "access_key",           # The SSH key name for provisioning the instance.
#       "root_block_device_volume_type": "gp3", # The type of the root block device.
#       "root_block_device_volume_size": 10,     # The volume size of the root block device in GB.
#       "associate_public_ip_address": true             # Associate a public IP address to provisioned instance.
#     }
#
#     These settings allow you to customize the provisioning process based on cloud provider and specific requirements.
#
# @param pe_server
#   The PE server to be used for provisioning the VMs
#
# @param environment
#   The puppet environment to be used to configure the provisioning the VMs
#
# @param os_type
#   The type of operating system type to be used for provisioning the VMs
#
plan provision::terraform::apply(
  String[1] $tf_dir,
  Provision::CloudProvider $provider,
  Provision::InstanceType $instance_size,
  Provision::HardwareArchitecture $hardware_architecture,
  String[1] $resource_name,
  String[1] $region,
  Optional[String[1]] $subnet,
  Optional[Array[String[1]]] $security_group_ids,
  Optional[Integer[1, 10]] $node_count,
  Optional[String[1]] $image,
  Optional[Hash[String[1], String[1]]] $tags,
  Optional[String[1]] $pe_server,
  Optional[String[1]] $environment,
  Optional[Enum['linux', 'windows']] $os_type,
  Optional[Provision::ProviderOptions] $provider_options,
  Optional[String[1]] $project,
) {
  if $provider == 'gcp' {
    $profile = provision::get_gcp_profile($project)
  } else {
    $profile = undef
  }
  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  out::message('Initializing Terraform for provisioning')
  run_task('terraform::initialize', 'localhost', dir => $tf_dir)

  # Constructs a tfvars file to be used by Terraform
  $tfvars = epp('provision/tfvars.epp', {
      resource_name          => $resource_name,
      region                 => $region,
      node_count             => $node_count,
      image                  => $image,
      subnet                 => $subnet,
      security_group_ids     => $security_group_ids,
      hardware_architecture  => $hardware_architecture,
      instance_size          => $instance_size,
      tags                   => $tags,
      provider_options       => $provider_options,
      pe_server              => $pe_server,
      environment            => $environment,
      os_type                => $os_type,
      project                => $project,
      profile                => $profile,
  })

  out::message('Applying terraform plan to provison instance')
  out::message("The plan will be store the state file named ${resource_name}.tfstate under ${tf_dir} directory")
  out::message("To destroy the provisioned instance, you should use the ${resource_name} as resource name to destroy the correct instance(s)")
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
