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
# @param ikey
#   duo_unix integration key
#
# @param skey
#  duo_unix secret key
#
# @param host
#  DUO api host
#
# @param failmode
#  Failmode for duo_unix configuration
#
# @param pushinfo
#  configure pushinfo setting for duo_unix
#
# @param autopush
#  autopush setting for duo_unix configuration
#
# @param groups
#   group duo_unix applies to
class duo_unix (
  String $duo_unix_version,
  String $pam_ssh_user_auth_version,
  String $ikey,
  String $skey,
  String $host,
  String $failmode,
  String $pushinfo,
  String $autopush,
  String $groups
) {
  contain duo_unix::install
  contain duo_unix::configure
  contain duo_unix::service

  Class['duo_unix::install']
  -> Class['duo_unix::configure']
  ~> Class['duo_unix::service']
}
