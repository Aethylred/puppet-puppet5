# puppet5::agent::config class
# 
# This class is used to configure the Puppet 5 agent
# 
# @example Declaring the class
#   include puppet5::config
#

class puppet5::agent::config(
  Variant[Boolean, Enum['true', 'false', 'present', 'absent']] $ensure = 'present', # lint:ignore:quoted_booleans                        
) {

  include puppet5::oscheck

  if $ensure == 'present' {
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