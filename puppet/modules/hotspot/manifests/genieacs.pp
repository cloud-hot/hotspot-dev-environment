# = Class: hotspot::genieacs
#
# This class is used to install nodejs, redis, mongodb
# and more with npm.
#
# == Parameters:
#
# == Requires:
#
# == Sample Usage:
#
#  include hotspot::genieacs
#
class hotspot::genieacs {
  class { 'nodejs':
    manage_repo => true,
    version     => '0.10.26-1chl1~precise1',
  }

  package { 'coffee-script':
    ensure   => '1.7.1',
    provider => 'npm',
    require  => Class['nodejs'],
  }
}
