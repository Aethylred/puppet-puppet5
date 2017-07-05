# This file is part of the puppet5 module
# 
# This test manifest sets up the Puppetlabs Puppet5 repository step by step without using the
# puppet5 wrapper class

include puppet5::repos
class { 'puppet5::install':
  require => Class['puppet5::repos']
}
class { 'puppet5::config':
  require => Class['puppet5::repos']
}