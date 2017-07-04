# puppet5 class
# 
# This class is used to install the Puppet 5 agent
# Installing a puppet5 repo is required, however the puppet5::repos class is
# not required as long as a repository is set up prior to calling this class
# 
# @example Declaring the class
#   include puppet5
#   
# @param [String] certname The hostname used to generate the certificate for server and agent
# 

class puppet5::install(
  String $package,
  String $version,
  Variant[Boolean, Enum['true', 'false', 'installed', 'absent']] $ensure = 'installed', # lint:ignore:quoted_booleans
) {

  include puppet5::oscheck

  if $ensure {
    $ensure_package = $version
    $ensure_dir     = 'directory'
    $ensure_file    = 'file'
    $ensure_present = 'present'
  } else {
    $ensure_package = 'absent'
    $ensure_dir     = 'absent'
    $ensure_file    = 'absent'
    $ensure_present = 'absent'
  }

  package{'puppet-agent':
    ensure => $ensure_package,
    name   => $package,
  }

}
