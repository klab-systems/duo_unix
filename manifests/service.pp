# @summary Managed SSHD service for duo_unix
#
# @example
#   include duo_unix::service
class duo_unix::service {
  service { 'sshd':
    ensure => running,
  }
}
