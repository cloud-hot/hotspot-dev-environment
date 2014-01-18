##hotspot recipe module

### Introduction

The is a combination of all the request module, and it is abstracted into a recipe which is an interface used by hotspot-precise64.pp.

## How to use

### Simple Example:
```
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'hotspot': }
hotspot::apache { 'apache.hotspot': }
```

### Full example:
```
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'hotspot':
  directory     => '/var/www/hotspot',
  repository    => 'git',
  version       => 'trunk',
  db_user       => 'username',
  db_password   => 'secure',
  log_analytics => true,
  svn_username  => 'myusername',
  svn_password  => 'mypassword',
}

hotspot::apache { 'apache.hotspot':
  port     => 80,
  docroot  => '/var/www/hotspot',
  priority => '10',
  require  => Class['hotspot'],
  user     => 'hotspot',
  group    => 'www',
}

hotspot::nginx { 'nginx.hotspot':
  port    => 8080,
  docroot => '/var/www/hotspot',
  require => Class['hotspot'],
  user    => 'hotspot',
  group   => 'www',
}
```

### Add further hotspot versions/hosts:
```
hotspot::repo { 'hotspot_repo_17':
  directory  => '/var/www/hotspot17',
  version    => 'tags/1.7',
  repository => 'svn',
  require    => Class['hotspot'],
}

hotspot::nginx { 'version17.hotspot':
  port     => 8170,
  docroot  => '/var/www/hotspot17',
  require  => hotspot::Repo['hotspot_repo_17'],
}
```

Do not forget to update your local hosts file when adding servers.

### Requirements
* puppetlabs-apache - https://github.com/puppetlabs/puppetlabs-apache 
* puppet-apt - https://github.com/camptocamp/puppet-apt
* puppet-common - https://github.com/puppet-modules/puppet-common
* puppetlabs-firewall - https://github.com/puppetlabs/puppetlabs-firewall
* puppetlabs-git - https://github.com/puppetlabs/puppetlabs-git
* puppetlabs-mysql - https://github.com/puppetlabs/puppetlabs-mysql
* puppetlabs-nginx - https://github.com/Mayflower/puppetlabs-nginx
* puppet-php - https://github.com/Mayflower/puppet-php
* puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
* puppet-vcsrepo - https://github.com/openstack-infra/puppet-vcsrepo 
* puppet-concat - https://github.com/ripienaar/puppet-concat

```
git submodule add git://github.com/puppetlabs/puppetlabs-apache modules/apache
git submodule add git://github.com/camptocamp/puppet-apt modules/apt
git submodule add git://github.com/puppet-modules/puppet-common modules/common
git submodule add git://github.com/puppetlabs/puppetlabs-firewall modules/Firewall
git submodule add git://github.com/puppetlabs/puppetlabs-git modules/git
git submodule add git://github.com/puppetlabs/puppetlabs-mysql modules/mysql
git submodule add git://github.com/Mayflower/puppetlabs-nginx modules/nginx
git submodule add git://github.com/Mayflower/puppet-php modules/php
git submodule add git://github.com/rafaelfelix/puppet-phpqatools modules/phpqatools
git submodule add git://github.com/puppetlabs/puppetlabs-stdlib modules/stdlib
git submodule add git://github.com/openstack-infra/puppet-vcsrepo modules/vcsrepo
```
