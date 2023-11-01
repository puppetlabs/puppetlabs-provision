# @summary
#   Installs the provisioning tool (Terraform) on the target node
#
# @param version
#   The version of Terraform to install
#
class provision (
  String[1] $version  = '1.5.7',
) {
  case $facts['os']['family'] {
    'RedHat', 'CentOS': {
      yumrepo { 'HashiCorp Terraform':
        baseurl  => 'https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo',
        descr    => 'HashiCorp Terraform Repo',
        enabled  => 1,
        gpgcheck => 1,
      }
    }
    'Debian', 'Ubuntu': {
      include apt

      apt::source { 'hashicorp':
        location => 'https://apt.releases.hashicorp.com',
        repos    => 'main',
        key      => {
          id     => '798AEC654E5C15428C8E42EEAA16FCBCA621E701',
          server => 'https://apt.releases.hashicorp.com/gpg',
        },
      }
    }
    default: {
      fail("Unsupported OS family: ${facts['os']['family']}")
    }
  }

  -> package { 'terraform' :
    ensure => $version,
  }
}
