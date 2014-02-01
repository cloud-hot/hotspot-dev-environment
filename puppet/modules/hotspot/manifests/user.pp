# = Class: hotspot::user
# 
# Makes sure the user exists which is used by Apache and NGINX.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include hotspot::user
#
class hotspot::user {
    
  # user for apache / nginx
  user { "${hotspot::params::web_user}":
    ensure  => present,
    comment => $hotspot::params::web_user,
    shell   => '/bin/false',
  }

}
