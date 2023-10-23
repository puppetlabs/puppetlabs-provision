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
# @param image
#   The cloud image that is used for new instance provisioning, format differs
#   depending on provider
#
plan provision::destroy(
  Enum['gcp', 'aws', 'azure']  $provider      = 'aws',
  String[1]                    $resource_name = undef,
  String[1]                    $profile       = undef,
  String[1]                    $image         = undef,
  Optional[String[1]]          $region        = undef,
) {
  $_tf_dir = "terraform/${provider}/"

  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  run_plan('provision::terraform::destroy', {
      tf_dir        => $_tf_dir,
      resource_name => $resource_name,
      profile       => $profile,
      image         => $image,
      region        => $region,
  })
  out::message('Provisioned infrastructure successfully destroyed')
}
