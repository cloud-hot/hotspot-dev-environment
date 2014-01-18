# = Definition: hotspot::repo
#
# This definition clones a specific version from a cloud-hot
# repository into the specified directory.
#
# == Parameters: 
#
# $directory::     The cloud-hot repository will be checked out/cloned into this 
#                  directory.
# $version::       The pkg version. Defaults to 'trunk'. 
#                  Valid values: For example 'HEAD', 'tags/1.8.3' or 'branch/whatever'.
# $repository::    Whether to checkout the SVN or Git reporitory. Defaults to svn. 
#                  Valid values: 'svn' and 'git'.  
# $svn_username::  Your svn username. Defaults to false.
# $svn_password::  Your svn password. Defaults to false.
#
# == Actions:
#
# == Requires: 
#
# == Sample Usage:
#
#  hotspot::repo { 'hotspot_repo_simple': 
#    source = 'https://github.com/cloud-hot/carrierwrt.git'
#  }
#
#  hotspot::repo { 'hotspot_repo_full':
#    directory    => '/home/hotspot/workspace',
#    source       => 'https://github.com/cloud-hot/carrierwrt.git'
#    version      => 'trunk',
#    repository   => 'svn',
#    svn_username => 'svn username',
#    svn_password => 'svn password'
#  }
#
define hotspot::repo(
  $directory    = $hotspot::params::workspace,
  $source       = false,
  $version      = master,
  $repository   = git,
  $svn_username = false,
  $svn_password = false
) {

  if ! defined(File[$directory]) {
    file { "${directory}": }
  }

  if $repository == 'svn' {
    vcsrepo { "${directory}":
      ensure   => present,
      provider => svn,
      source   => $source,
      owner    => $hotspot::params::user,
      group    => $hotspot::params::group,
      require  => [ User["${hotspot::params::user}"], Package['subversion'] ],
      basic_auth_username => $svn_username,
      basic_auth_password => $svn_password,
    }
  }

  if $repository == 'git' {
    vcsrepo { "${directory}":
      ensure   => present,
      provider => git,
      source   => $source,
      revision => $version,
      owner    => $hotspot::params::user,
      group    => $hotspot::params::group,
      require  => [ User["${hotspot::params::user}"], Class['git'] ],
    }
  }

  file { "${directory}/config":
    ensure    => directory,
    mode      => '0777',
    subscribe => Vcsrepo["${directory}"],
  }

  file { "${directory}/tmp":
    ensure    => directory,
    mode      => '0777',
    subscribe => Vcsrepo["${directory}"],
  }

}
