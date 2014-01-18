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
  $log_store   = true
) inherits hotspot::params {

  include hotspot::base

#  if $log_store == true {
#    include hotspot::log
#  }

  class { 'hotspot::user': }

  # repo checkout wrt
  hotspot::repo { 'wrt_repo_setup':
    directory    => $hotspot::params::workspace,
    source       => $hotspot::params::wrt_repository,
    version      => $hotspot::params::wrt_version,
    repository   => $hotspot::params::wrt_provider,
    require      => Class['hotspot::base'],
  }

  # repo checkout owm
  hotspot::repo { 'owm_repo_setup':
    directory    => $hotspot::params::workspace,
    source       => $hotspot::params::owm_repository,
    version      => $hotspot::params::owm_version,
    repository   => $hotspot::params::owm_provider,
    require      => Class['hotspot::base'],
  }

  # repo checkout owgm
  hotspot::repo { 'owgm_repo_setup':
    directory    => $hotspot::params::workspace,
    source       => $hotspot::params::owgm_repository,
    version      => $hotspot::params::owgm_version,
    repository   => $hotspot::params::owgm_provider,
    require      => Class['hotspot::base'],
  }

  # repo checkout vboot
  hotspot::repo { 'vboot_repo_setup':
    directory    => $hotspot::params::workspace,
    source       => $hotspot::params::vboot_repository,
    version      => $hotspot::params::vboot_version,
    repository   => $hotspot::params::vboot_provider,
    require      => Class['hotspot::base'],
  }

}
