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
  $rvm_user = $hotspot::params::dev_user
) {

  class { 'rvm':
    branch => 'master'
  }

  rvm::system_user {
    $rvm_user: ;
  }

  if $rvm_installed == "true" {

    rvm_system_ruby {
      'ree-1.8.7-2012.02':
        ensure      => 'present',
        require     => Class['rvm::system'],
        default_use => true;
#      'ruby-2.1.0':
#        ensure      => 'present',
#        require     => Class['rvm::system'],
#        default_use => false;
    }

#    rvm_gemset {
#      "ree-1.8.7-2012.02@openwisp":
#      ensure => present,
#      require => Rvm_system_ruby['ree-1.8.7-2012.02'];
#    }

#    rvm_gem {
#      'ree-1.8.7-2012.02@openwisp/bundler':
#      ensure => '1.8.15',
#      require => Rvm_gemset['ree-1.8.7-2012.02@openwisp'];
#    }

    #this is needed by passenger
    rvm_gem {
      'bundler':
      name => 'bundler',
      ruby_version => 'ree-1.8.7-2012.02',
      ensure => latest,
      require => Rvm_system_ruby['ree-1.8.7-2012.02'];
    }

    class {
      'rvm::passenger::apache':
        version            => '4.0.33',
        ruby_version       => 'ree-1.8.7-2012.02',
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
    docroot    => "/home/${hotspot::params::dev_user}/workspace/owm/public",
    require    => Vcsrepo["owm"],
  }

}