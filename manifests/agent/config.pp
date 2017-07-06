# puppet5::agent::config class
# 
# This class is used to configure the Puppet 5 agent
# 
# @example Declaring the class
#   include puppet5::config
#

class puppet5::agent::config(
  Variant[Boolean, Enum['true', 'false', 'present', 'absent']] $ensure = 'present', # lint:ignore:quoted_booleans
  Array[String] $basemodulepaths = [],
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

  $path_string_format = {
    Array => {
      format         => '% a',
      separator      => ':',
      string_formats => {
        String => '%s'
      }
    }
  }

# Turn the array of basemodulepaths to a basemodulepath string
# basemodule path is used in the puppet.conf template
  if $basemodulepaths != [] {
    $basemodulepath = String($basemodulepaths, $path_string_format)
  } else {
    # Just making this explicit
    $basemodulepath = undef
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