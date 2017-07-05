# puppet5 class
# 
# This class is used to install and configure the Puppet 5 agent
# Installing a puppet5 repo is required, however the puppet5::repos class is
# not required as long as a repository is set up prior to calling this class
# 
# This class calls the install, config and service classes in sequence for a simplified
# one class definition of the puppet-agent
# 
# @example Declaring the class
#   include puppet5
#   
# @param [String] package The package to be installed
# @param [String] version The version of the package to be installed
# @param [String] ensure Ensure if the package is `installed` or `absent`, the default is `installed`

class puppet5(
  String $package,
  String $version,
  Variant[Boolean, Enum['true', 'false', 'installed', 'absent']] $ensure = 'installed', # lint:ignore:quoted_booleans
) {

  include puppet5::oscheck

  class {'puppet5::install':
    ensure  => $ensure,
    package => $package,
    version => $version
  }

}
