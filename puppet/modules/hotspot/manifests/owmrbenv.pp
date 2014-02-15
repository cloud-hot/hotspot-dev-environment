# = Class: hotspot::owm
# 
# This class is used to install ruby, passenger, apache
# and more with rbenv.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include hotspot::owmrbenv
#
class hotspot::owmrbenv (
  $rbenv_user = $hotspot::params::dev_user
) {

  rbenv::install { "$rbenv_user": }

  rbenv::compile { "1.8.7-p375":
    user => "$rbenv_user",
  }

  rbenv::compile { "2.1.0":
    user => "$rbenv_user",
  }

  rbenv::plugin { "rbenv-binstubs":
    user   => "$rbenv_user",
    source => "https://github.com/ianheggie/rbenv-binstubs.git"
  }

  class {
    'rbenv::passenger::apache':
      user               => "$rbenv_user",
      version            => '4.0.33',
      ruby_version       => '1.8.7-p375',
      gem_version        => '1.8',
      rbenv_prefix       => "/home/${rbenv_user}/",
      mininstances       => '3',
      maxinstancesperapp => '0',
      maxpoolsize        => '30',
      spawnmethod        => 'smart-lv2';
  }

  include apache

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