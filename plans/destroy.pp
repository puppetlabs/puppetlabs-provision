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
  Provision::CloudProvider  $provider      = 'aws',
  String[1]                 $resource_name = 'puppetlabs-provision',
  String[1]                 $profile       = undef,
  Optional[String[1]]       $region        = 'us-west-2',
) {
  $_tf_dir = "terraform/${provider}/"

  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  run_plan('provision::terraform::destroy', {
      tf_dir        => $_tf_dir,
      resource_name => $resource_name,
      profile       => $profile,
      region        => $region,
  })
  out::message('Provisioned infrastructure successfully destroyed')
}
