# = Class: hotspot::base
# 
# This class installes some base packages like git, subversion, vim
# and more.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include hotspot::base
#
class hotspot::base {

  class { 'hotspot::ppa':
    clean_sources_list => true
  }

  notify { "apt-get_update": }

  exec { "base_apt-get_update":
    command => "apt-get update",
    require => Class['hotspot::ppa']
  }

  include git

  include tftp

  $base_packages = [
    'vim',
    'facter',
    'strace',
    'tcpdump',
    'wget',
    'curl',
    'tree',
    'liblzma-dev',
    'dos2unix',
  ]

  package { $base_packages :
    ensure => installed,
    require => Exec['base_apt-get_update']
  }

  $openwrt_packages = [
    'build-essential',
    'subversion',
    'git-core',
    'libncurses5-dev',
    'gawk',
    'flex',
    'quilt',
    'libssl-dev',
    'xsltproc',
    'libxml-parser-perl',
    'mercurial',
    'bzr',
    'ecj',
    'cvs',
    'unzip',
  ]

  package { $openwrt_packages :
    ensure => installed,
    require => Exec['base_apt-get_update']
  }

  $genieacs_packages = [
    'mongodb',
    'redis-server',
  ]

  package { $genieacs_packages :
    ensure => installed,
    require => Exec['base_apt-get_update']
  }
}
