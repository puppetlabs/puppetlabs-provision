# @summary
#   Installs the provisioning tool (Terraform) on the target node
#
# @param version
#   The version of Terraform to install
#
# @param provider
#   The provider to install (aws, azure, gcp, etc.)
#
class provision (
  String[1] $version  = '1.5.7',
  String[1] $provider = 'aws',
) {
  if $facts['os']['family'] == 'RedHat' {
    yumrepo { 'HashiCorp Terraform':
      baseurl  => 'https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo',
      descr    => 'HashiCorp Terraform Repo',
      enabled  => 1,
      gpgcheck => 1,
    }
  } elsif $facts['os']['family'] == 'Debian' {
    include apt

    apt::source { 'hashicorp':
      location => 'https://apt.releases.hashicorp.com',
      repos    => 'main',
      key      => {
        id     => '798AEC654E5C15428C8E42EEAA16FCBCA621E701',
        server => 'https://apt.releases.hashicorp.com/gpg',
      },
    }
  } else {
    fail("Unsupported OS family: ${facts['os']['family']}")
  }

  package { 'terraform' :
    ensure => $version,
  }
}
