# puppet5::agent::install class
# 
# This class is used to install the Puppet 5 agent
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

class puppet5::agent::install(
  String $package = lookup('puppet5::package'),
  String $version = lookup('puppet5::version'),
  Variant[Boolean, Enum['true', 'false', 'installed', 'absent']] $ensure = 'installed', # lint:ignore:quoted_booleans
) {

  include puppet5::oscheck

  if $ensure == 'installed' {
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

  $dir_defaults = {
    ensure => $ensure_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  create_resources(file, lookup('puppet5::directories', Hash, 'hash'), $dir_defaults)
}
