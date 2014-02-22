# = Class: hotspot::ppa
# 
# This class is used to manage apt sources.list files
# and more.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include hotspot::ppa
#
class hotspot::ppa (
  $clean_sources_list = true
) {

  class { 'apt':
    purge_sources_list => $clean_sources_list
  }

  apt::source { "puppetlabs_precise":
    location     => "http://apt.puppetlabs.com/",
    release      => "precise",
    repos        => "main",
    include_src  => false,
    key          => 4BD6EC30
  }

  apt::source { "163_precise":
    location     => "http://mirrors.163.com/ubuntu/",
    release      => "precise",
    repos        => "main restricted universe multiverse",
    include_src  => false,
    key          => 4BD6EC30,
  }

  apt::source { "163_precise_updates":
    location     => "http://mirrors.163.com/ubuntu/",
    release      => "precise-updates",
    repos        => "main restricted universe multiverse",
    include_src  => false,
    key          => 4BD6EC30,
  }

  apt::source { "163_precise_security":
    location     => "http://mirrors.163.com/ubuntu/",
    release      => "precise-security",
    repos        => "main restricted universe multiverse",
    include_src  => false,
    key          => 4BD6EC30,
  }

  class { 'apt::backports':
    location     => "http://mirrors.163.com/ubuntu/",
    release      => "precise",
  }

}