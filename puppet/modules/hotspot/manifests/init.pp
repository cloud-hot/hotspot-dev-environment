# = Class: hotspot
# 
# This class installs all required packages and services in order to develope
# cloud hotspot. 
# It'll do a checkout of the our carrierwrt development repository as well.
# You only have to setup Apache and/or NGINX afterwards.
# 
# == Parameters: 
#
# $directory::         The carrierwrt repository will be checked out into this directory.
# $repository::        Whether to checkout the SVN or Git reporitory. Defaults to svn. 
#                      Valid values: 'svn' and 'git'. 
# $version::           The carrierwrt version. Defaults to 'trunk'. 
#                      Valid values: For example 'tags/1.8.3' or 'branch/whatever'. 
# $db_user::           If defined, it creates a MySQL user with this username.
# $db_password::       The MySQL user's password.
# $db_root_password::  A password for the MySQL root user.
# $log_analytics::     Whether log analytics will be used. Defaults to true. 
#                      Valid values: true or false
# $svn_username::      Your svn username. Defaults to false.
# $svn_password::      Your svn password. Defaults to false.
# 
# == Requires: 
# 
# See README
# 
# == Sample Usage:
#
#  class {'hotspot': }
#
#  class {'hotspot':
#    db_root_password => '123456',
#    repository => 'git',
#  }
#
class hotspot(
  $directory   = $hotspot::params::docroot,
  $repository  = $hotspot::params::repository,
  $version     = $hotspot::params::hotspot_version,
  $db_user     = $hotspot::params::db_user,
  $db_password = $hotspot::params::db_password,
  $db_root_password = $hotspot::params::db_password,
  $log_analytics    = true,
  $svn_username     = false,
  $svn_password     = false
) inherits hotspot::params {

  include hotspot::base

  # mysql / db
  class { 'hotspot::db':
    username      => $db_user,
    password      => $db_password,
    root_password => $db_root_password,
    require       => Class['hotspot::base'],
  }

  class { 'hotspot::php':
     require => Class['hotspot::db'],
  }

  if $log_analytics == true {
    include hotspot::loganalytics
  }

  class { 'hotspot::user': }

  # repo checkout
  hotspot::repo { 'hotspot_repo_setup':
    directory    => $directory,
    version      => $version,
    repository   => $repository,
    svn_username => $svn_username,
    svn_password => $svn_password,
    require      => Class['hotspot::base'],
  }

  exec { 'run_hotspot_composer':
    command => "composer.phar update",
    cwd     => $directory,
    require => [ hotspot::repo['hotspot_repo_setup'], Class['hotspot::php'] ],
  }

}
