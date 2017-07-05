# puppet5::config class
# 
# This class is used to configure the Puppet 5 agent
# 
# @example Declaring the class
#   include puppet5::config
#

class puppet5::config(
  Variant[Boolean, Enum['true', 'false', 'installed', 'absent']] $ensure = 'installed', # lint:ignore:quoted_booleans                        
) {

  include puppet5::oscheck

  if $ensure == 'installed' {
    $ensure_dir     = 'directory'
    $ensure_file    = 'file'
    $ensure_present = 'present'
  } else {
    $ensure_dir     = 'absent'
    $ensure_file    = 'absent'
    $ensure_present = 'absent'
  }

  file{'puppet.conf':
    ensure  => $ensure_file,
    path    => lookup('puppet5::files.puppetconf.path', String, 'first'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet5/puppet.conf.erb')
  }

}