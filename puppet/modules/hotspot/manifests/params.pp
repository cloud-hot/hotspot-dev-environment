# = Class: hotspot::params
# 
# This class manages hotspot parameters
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
# This class file is not called directly
#
class hotspot::params {
  $user    = 'www-data'
  $group   = 'www-data'
  $docroot = '/var/www/hotspot'

  $repository     = 'git'
  $svn_repository = 'http://dev.hotspot.org/svn/'
  $git_repository = 'https://github.com/cloud-hot/carrierwrt.git'
  $hotspot_version  = 'trunk'

  $db_user     = 'hotspot@localhost'
  $db_password = 'secure'
}
