# --- Globe setting ------------------------------------------------------------

Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

# --- Preinstall Stage ---------------------------------------------------------

#stage { 'preinstall':
#  before => Stage['main']
#}

#class apt_get_update {
#  exec { 'apt-get -y update':
#    unless => "test -e ${home}/.rvm"
#  }
#}

#class { 'apt_get_update':
#  stage => preinstall
#}

# --- hotspot class install ----------------------------------------------------

class { 'hotspot':
  directory     => '/home/vagrant/www/hotspot',
  repository    => 'git',
  version       => 'master',
  db_user       => $db_username,
  db_password   => $db_password,
  log_analytics => true,
}

hotspot::nginx { 'hotspot-dev-box':
  port    => 8080,
  docroot => '/home/vagrant/www/hotspot',
  require => Class['hotspot'],
  user     => 'vagrant',
  group    => 'vagrant',
}
