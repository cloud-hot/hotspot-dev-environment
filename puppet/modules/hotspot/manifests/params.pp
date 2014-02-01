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
  $web_user      = 'hotspot'
  $web_group     = 'hotspot'
  $dev_user      = 'vagrant'
  #dev_group     = 'vagrant'
  $workspace = "/home/${dev_user}/workspace"

  $wrt_repository   = 'https://github.com/cloud-hot/carrierwrt.git'
  $wrt_version      = 'master'

  $owm_repository   = 'https://github.com/cloud-hot/OpenWISP-Manager.git'
  $owm_version      = 'master'

  $owgm_repository  = 'https://github.com/cloud-hot/OpenWISP-Geographic-Monitoring.git'
  $owgm_version     = 'master'

  $vboot_repository = 'https://github.com/cloud-hot/vboot_reference.git'
  $vboot_version    = 'master'
}
