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

class puppet5(
  String $certname
  ) {

  include puppet5::oscheck

}
