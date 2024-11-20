# @summary Installs, Configures, and Manages duo_unix and its dependencies
#
# @example
#   include duo_unix
class duo_unix {
  contain duo_unix::install
  contain duo_unix::configure
  contain duo_unix::service

  Class['duo_unix::install']
  -> Class['duo_unix::configure']
  ~> Class['duo_unix::service']
}
