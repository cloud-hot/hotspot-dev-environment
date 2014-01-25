# = Class: hotspot::owm
# 
# This class is used to install rvm, ruby, passenger, apache
# and more.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include hotspot::owm
#
class hotspot::owm (
  $rvm_user = $hotspot::params::user
) {

  include rvm

  rvm::system_user {
    $rvm_user: ; vagrant: ;
  }

  if $rvm_installed == "true" {

    rvm_system_ruby {
      'ree-1.8.7':
        ensure      => 'present',
        require     => Class['rvm::system'],
        default_use => true;
#      'ruby-2.1.0':
#        ensure      => 'present',
#        require     => Class['rvm::system'],
#        default_use => false;
    }

    class {
      'rvm::passenger::apache':
        version            => '4.0.33',
        ruby_version       => 'ree-1.8.7',
        mininstances       => '3',
        maxinstancesperapp => '0',
        maxpoolsize        => '30',
        spawnmethod        => 'smart-lv2';
    }

  }

  include apache

  apache::vhost { 'sowm.example.com':
    servername => 'owm.example.com',
    ip         => '127.0.0.1',
    docroot    => "/home/${hotspot::params::user}/workspace/owm/public",
  }

}