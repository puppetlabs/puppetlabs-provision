function provision::gcp_profile() >> String {
  $google_credentials = system::env('GOOGLE_CREDENTIALS')
  $google_application_credentials = system::env('GOOGLE_APPLICATION_CREDENTIALS')

  if $google_credentials {
    $profile = $google_credentials
  } elsif $google_application_credentials {
    $profile = $google_application_credentials
  } else {
    $profile = undef
  }

  return $profile
}
