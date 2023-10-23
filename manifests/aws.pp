# Manifest to configure the pre-requisites for puppetlabs-provision module
#
# @param access_key_id
#    Optional IAM access key with EC2 privileges
#
# @param secret_access_key
#    Optional IAM secret access key associated with the access key ID
#
# @param session_token
#    Optional session token for AWS STS credentials, as the STS credentials are bound with time so this 
#    parameter is not supported with Hiera configurations.
#
# @param profile
#    Optional profile name to use for credentials
#
class provision::aws (
  Optional[String[1]] $access_key_id     = undef,
  Optional[String[1]] $secret_access_key = undef,
  Optional[String[1]] $session_token     = undef,
  String[1] $profile                     = 'default',
) {
  $parameters = {
    'access_key_id' => $access_key_id,
    'secret_access_key' => $secret_access_key,
    'session_token' => $session_token,
    'profile' => $profile,
  }

  file {
    '/root/.aws':
      ensure => directory,
      mode   => '0755',
      ;

    '/root/.aws/credentials':
      ensure  => file,
      mode    => '0400',
      content => epp('provision/credentials.epp', $parameters),
      ;
  }
}
