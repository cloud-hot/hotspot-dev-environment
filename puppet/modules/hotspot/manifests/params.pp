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
  $user      = 'hotspot'
  $group     = 'hotspot'
  $workspace = "/home/${user}/workspace"

  $wrt_provider     = 'git'
  $wrt_repository   = 'https://github.com/cloud-hot/carrierwrt.git'
  $wrt_version      = 'master'

  $owm_provider     = 'git'
  $owm_repository   = 'https://github.com/cloud-hot/OpenWISP-Manager.git'
  $owm_version      = 'master'

  $owgm_provider     = 'git'
  $owgm_repository  = 'https://github.com/cloud-hot/OpenWISP-Geographic-Monitoring.git'
  $owgm_version     = 'master'

  $vboot_provider     = 'git'
  $vboot_repository = 'https://github.com/cloud-hot/vboot_reference.git'
  $vboot_version    = 'master'
}
