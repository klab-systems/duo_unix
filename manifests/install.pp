# @summary Configures repositories, installs neccessary packages
#
# @example
#   include duo_unix::install
class duo_unix::install {
  yumrepo { 'duosecurity':
    ensure   => 'present',
    enabled  => '1',
    descr    => 'Duo Inc. official repository',
    baseurl  => "https://pkg.duosecurity.com/${facts['os']['name']}/\$releasever/\$basearch",
    gpgkey   => 'https://duo.com/DUO-GPG-PUBLIC-KEY.asc',
    gpgcheck => '1',
  }

  package { 'duo_unix':
    ensure  => lookup('duo_unix::duo_unix_version'),
    require => Yumrepo['duosecurity'],
  }

  package { 'pam_ssh_user_auth':
    ensure => lookup('duo_unix::pam_ssh_user_auth_version'),
  }
}
