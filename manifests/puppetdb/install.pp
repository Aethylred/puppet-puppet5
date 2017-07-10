# puppet5::puppetdb::install class
# 
# This class is used to install the Puppet 5 PuppetDB
# Installing a puppet5 repo is required, however the puppet5::repos class is
# not required as long as a repository is set up prior to calling this class
# 
# @example Declaring the class
#   include puppet5
#   
# @param [String] package The package to be installed
# @param [String] version The version of the package to be installed
# @param [String] ensure Ensure if the package is `installed` or `absent`, the default is `installed`
# 

class puppet5::puppetdb::install(
  String $package = lookup('puppet5::puppetdb::package'),
  String $version = lookup('puppet5::puppetdb::version'),
  Variant[Boolean, Enum['installed', 'absent']] $ensure = 'installed',
) {

  case $ensure {
    true, 'installed': {
      $ensure_package = $version
      $ensure_dir     = 'directory'
      $ensure_present = 'present'
    }
    default: {
      $ensure_package = 'absent'
      $ensure_dir     = 'absent'
      $ensure_present = 'absent'
    }
  }

  package{'puppetdb':
    ensure => $ensure_package,
    name   => $package,
  }
}