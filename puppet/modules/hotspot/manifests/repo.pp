# = Definition: hotspot::repo
#
# This definition clones a specific version from a cloud-hot
# repository into the specified directory, only support git.
#
# == Parameters: 
#
# $directory::     The cloud-hot repository will be checked out/cloned into this 
#                  directory.
# $version::       The pkg version. Defaults to 'trunk'. 
#                  Valid values: For example 'HEAD', 'tags/1.8.3' or 'branch/whatever'.
# $repository::    Whether to checkout the SVN or Git reporitory. Defaults to git. 
#                  Valid values: 'svn' and 'git'.  
#
# == Actions:
#
# == Requires: 
#
# == Sample Usage:
#
#  hotspot::repo { 'hotspot_repo_simple': 
#  }
#
#  hotspot::repo { 'hotspot_repo_full':
#    directory      => '/home/hotspot/workspace',
#    wrt_repository => 'https://github.com/cloud-hot/carrierwrt.git'
#    wrt_version    => 'master',
#  }
#
define hotspot::repo(
  $directory        = $hotspot::params::workspace,
  $wrt_repository   = $hotspot::params::wrt_repository,
  $wrt_version      = $hotspot::params::wrt_version,
  $owm_repository   = $hotspot::params::owm_repository,
  $owm_version      = $hotspot::params::owm_version,
  $owgm_repository  = $hotspot::params::owgm_repository,
  $owgm_version     = $hotspot::params::owgm_version,
  $vboot_repository = $hotspot::params::vboot_repository,
  $vboot_version    = $hotspot::params::vboot_version,
) {

  if ! defined(File[$directory]) {
    file { "${directory}":
       owner => vagrant,
       group => vagrant,
       mode => 644
    }
  }

  vcsrepo { "wrt":
    ensure   => present,
    path     => "${directory}/carrierwrt",
    provider => git,
    source   => $wrt_repository,
    revision => $wrt_version,
    owner    => $hotspot::params::dev_user,
    group    => $hotspot::params::dev_group,
    require  => [ User["${hotspot::params::dev_user}"], Class['git'] ],
  }

  vcsrepo { "owm":
    ensure   => present,
    path     => "${directory}/owm",
    provider => git,
    source   => $owm_repository,
    revision => $owm_version,
    owner    => $hotspot::params::dev_user,
    group    => $hotspot::params::dev_group,
    require  => [ User["${hotspot::params::dev_user}"], Class['git'] ],
  }

  vcsrepo { "owgm":
    ensure   => present,
    path     => "${directory}/owgm",
    provider => git,
    source   => $owgm_repository,
    revision => $owgm_version,
    owner    => $hotspot::params::dev_user,
    group    => $hotspot::params::dev_group,
    require  => [ User["${hotspot::params::dev_user}"], Class['git'] ],
  }

  vcsrepo { "vboot":
    ensure   => present,
    path     => "${directory}/vboot",
    provider => git,
    source   => $vboot_repository,
    revision => $vboot_version,
    owner    => $hotspot::params::dev_user,
    group    => $hotspot::params::dev_group,
    require  => [ User["${hotspot::params::dev_user}"], Class['git'] ],
  }

  exec { "clone wrt done": 
    command => "echo clone wrt complete",
    subscribe => Vcsrepo["wrt"],
  }

  exec { "clone owm done": 
    command => "echo clone owm complete",
    subscribe => Vcsrepo["owm"],
  }

  exec { "clone owgm done": 
    command => "echo clone owgm complete",
    subscribe => Vcsrepo["owgm"],
  }

  exec { "clone vboot done": 
    command => "echo clone vboot complete",
    subscribe => Vcsrepo["vboot"],
  }

}
