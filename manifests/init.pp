# @summary Installs, Configures, and Manages duo_unix and its dependencies
#
# @example
#   include duo_unix
#
# @param duo_unix_version
#   Specificies the version of duo_unix to install
#
# @param pam_ssh_user_auth_version
#  Specifies the version of pam_ssh_user_auth to install
#
# @param pam_config
#  Configuration settings for /etc/duo/pam_duo.conf
class duo_unix (
  String $duo_unix_version,
  String $pam_ssh_user_auth_version,
  Hash[String, String] $pam_config,
) {
  contain duo_unix::install
  contain duo_unix::configure
  contain duo_unix::service

  Class['duo_unix::install']
  -> Class['duo_unix::configure']
  ~> Class['duo_unix::service']
}
