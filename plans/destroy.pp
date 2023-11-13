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
  String[1]                 $resource_name,
  Optional[String[1]]       $region            = 'us-west-2',
  Optional[Provision::ProviderOptions] $provider_options = undef,
  Optional[String[1]]       $profile            = undef,
  Optional[String[1]]       $project            = undef,
  Optional[String[1]]       $subnetwork_project = undef,
) {
  $_tf_dir = "terraform/${provider}/"

  if $provider == 'gcp' {
    $google_credentials = system::env('GOOGLE_CREDENTIALS')
    $google_application_credentials = system::env('GOOGLE_APPLICATION_CREDENTIALS')

    if  $google_credentials == undef and $google_application_credentials == undef {
      fail('GOOGLE_CREDENTIALS or GOOGLE_APPLICATION_CREDENTIALS environment variable is required for Google Cloud Provider')
    } elsif $google_credentials {
      $_profile = $google_credentials
    } else {
      $_profile = $google_application_credentials
    }

    if $project == undef {
      fail('project is required for Google Cloud Provider')
    }

    if $subnetwork_project == undef {
      $_subnetwork_project = $project
    }
  }

  if $provider != 'gcp' {
    $_profile = $profile
  }
  # Ensure the Terraform project directory has been initialized ahead of
  # attempting an apply
  run_plan('provision::terraform::destroy', {
      tf_dir           => $_tf_dir,
      provider         => $provider,
      resource_name    => $resource_name,
      provider_options => $provider_options,
      profile             => $_profile,
      region              => $region,
      project             => $project,
      subnetwork_project  => $_subnetwork_project
  })
  out::message('Provisioned infrastructure successfully destroyed')
}
