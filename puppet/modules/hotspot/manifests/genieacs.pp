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

  package { 'libxmljs':
    ensure   => '0.8.1',
    provider => 'npm',
    require  => Class['nodejs'],
  }

  package { 'redis':
    ensure   => '0.10.0',
    provider => 'npm',
    require  => Class['nodejs'],
  }

  package { 'hiredis':
    ensure   => '0.1.15',
    provider => 'npm',
    require  => Class['nodejs'],
  }

  package { 'mongodb':
    ensure   => '1.3.23',
    provider => 'npm',
    require  => Class['nodejs'],
  }
}
