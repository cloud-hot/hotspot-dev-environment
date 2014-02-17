# = Class: hotspot::owm
# 
# This class is used to install ruby, passenger, apache
# and more with rvm.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include hotspot::owmrvm
#
class hotspot::owmrvm (
  $rvm_user = $hotspot::params::dev_user
) {

  class { 'rvm':
    branch  => 'master',
    version => 'head',
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
    }

    #this is needed by passenger
    rvm_gem {
      'bundler':
      name => 'bundler',
      ruby_version => 'ree-1.8.7-2012.02',
      ensure => present,
      require => Rvm_system_ruby['ree-1.8.7-2012.02'];
    }

    #this is needed by openwisp
    rvm_gem {
      'rubygems-update':
      name => 'rubygems-update',
      ruby_version => 'ree-1.8.7-2012.02',
      ensure => '1.8.25',
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

  include apache::mod::rewrite

  apache::vhost { 'owm.example.com':
    servername => 'owm.example.com',
    port       => '80',
    docroot    => "/home/${hotspot::params::dev_user}/workspace/owm/public",
    require    => Vcsrepo["owm"],
  }

  $owm_packages = [
    'libarchive-dev',
  ]

  package { $owm_packages :
    ensure => installed,
    require => Exec['base_apt-get_update']
  }
}