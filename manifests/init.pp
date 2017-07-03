# Puppet class
# 
# This is the base class that can be used to install and manage all the Puppet5 things in this module
# 
# @example Declaring the class
#   include puppet
#   
# @param [String] certname The hostname used to generate the certificate for server and agent
# 

class puppet5(
  String $certname
  ) {
  # Do nothing right now ok
}
