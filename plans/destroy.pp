# @summary Destroy a earlier provisioned virtual machine 
#
# @param provider
#   Which cloud provider that infrastructure will be provisioned into
#
# @param region
#   Which region to provision infrastructure in, if not provided default will
#   be determined by provider
#
# @param resource_name
#   The name of the resource to be provisioned on respective cloud provider
#
# @param profile
#   The name of the profile to be used for provisioning
#
plan provision::destroy(
  Provision::CloudProvider  $provider          = 'aws',
  String[1]                 $resource_name     = 'provision',
  Optional[String[1]]       $region            = 'us-west-2',
  Provision::ProviderOptions $provider_options = undef,
) {
  $_tf_dir = "terraform/${provider}/"

  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  run_plan('provision::terraform::destroy', {
      tf_dir           => $_tf_dir,
      provider         => $provider,
      resource_name    => $resource_name,
      region           => $region,
      provider_options => $provider_options,
  })
  out::message('Provisioned infrastructure successfully destroyed')
}
