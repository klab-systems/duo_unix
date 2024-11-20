# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include duo_unix::configure
class duo_unix::configure {
  $aug_pam_path = '/files/etc/pam.d/password-auth'
  $aug_match = "${aug_pam_path}/*/module[. = '/lib64/security/pam_duo.so']"

  augeas { 'Duo Security SSH Configuration':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      'set UsePAM yes',
      'set UseDNS no',
      'set ChallengeResponseAuthentication yes',
      'set ExposeAuthInfo yes',
    ],
  }

  augeas { 'Duo Security PAM Configuration':
    changes => [
      "set ${aug_pam_path}/2/control requisite",
      "ins 100 after ${aug_pam_path}/2",
      "set ${aug_pam_path}/100/type auth",
      "set ${aug_pam_path}/100/control sufficient",
      "set ${aug_pam_path}/100/module /lib64/security/pam_duo.so",
    ],
    onlyif  => "match ${aug_match} size == 0";
  }

  file { '/etc/duo/pam_duo.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => epp('duo_unix/duo.conf.epp', { * => lookup('duo_unix::pam_duo_conf_settings') }),
  }
}
