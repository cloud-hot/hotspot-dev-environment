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
class hotspot (
  $log_store   = true
) inherits hotspot::params {

  include hotspot::base

#  if $log_store == true {
#    include hotspot::log
#  }

  class { 'hotspot::user': }

  # repo checkout all
  hotspot::repo { 'dev_repo_setup':
    require      => Class['hotspot::base'],
  }

}
