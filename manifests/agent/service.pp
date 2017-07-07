# puppet5::agent::service class
# 
# This class is used to configure the Puppet 5 agent
# 
# @example Declaring the class
#   include puppet5::service
#
# NOTE: Spaces are stripped from paths when they substituted into puppet.conf
#       What kind of monster uses spaces in paths?
#       
# @param [String] ensure If set to 'present' puppet.conf is deployed, if 'absent' it is removed. Default 'installed'
# @param [String] server Sets the FQDN of a puppet server or puppet master. Default is undefined.
# @param [String] environment  Sets the puppet environment. Default is undefined.
# @param [String] runinterval Sets how often the puppet agent runs. By default the puppet agent will run every 30m
# @param [Array[String]] basemodulepaths An array of paths used to set the basemoduelpath setting that lists the directories where puppet checks for modules.

class puppet5::agent::service(
  Variant[Boolean, Enum['enabled', 'running', 'stopped', 'disabled', 'absent']] $ensure = 'enabled',
) {

  case $ensure {
    true, 'enabled', 'running': {
      $ensure_service = 'enabled'
      $service_enabled = true
      $ensure_file = 'file'
    }
    default: {
      $ensure_service = 'absent'
      $service_enabled = false
      $ensure_file = 'absent'
    }
  }

  case $::operatingsystemmajrelease {
    '7': {
      # Use systemd
      file{'puppet_systemd_unit':
        ensure  => $ensure_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('puppet5/puppet.service.erb'),
        before  => Service['puppet-agent'],
      }
    }
    default: {
      # Use init.d/rc.d
      # Do nothing for now
    }
  }

  service{'puppet-agent':
    ensure  => $ensure_service,
    enabled => $service_enabled,
  }

}