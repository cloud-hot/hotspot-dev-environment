# --- Globe setting ------------------------------------------------------------

Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

# --- hotspot class install ----------------------------------------------------

class { 'hotspot':
  log_store => true,
}
