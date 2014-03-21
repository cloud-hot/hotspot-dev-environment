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

  $genieacs_gui_repository = 'https://github.com/cloud-hot/genieacs-gui.git'
  $genieacs_gui_version    = 'master'

  $genieacs_repository = 'https://github.com/cloud-hot/genieacs.git'
  $genieacs_version    = 'master'

  $freecwmp_repository = 'git://dev.freecwmp.org/freecwmp/'
  $freecwmp_version    = 'master'

  $microxml_repository = 'git://dev.freecwmp.org/microxml/'
  $microxml_version    = 'master'

  $openwrt_tr069_repository = 'git://dev.freecwmp.org/packages-openwrt-tr069/'
  $openwrt_tr069_version    = 'master'

  $countly_server_repository = 'https://github.com/cloud-hot/countly-server.git'
  $countly_server_version    = 'master'
}
