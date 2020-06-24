# execute 'apt-get update'
exec { 'apt-update':                    # exec resource named 'apt-update'
  command => '/usr/bin/apt-get update'  # command this resource will run
}

# install apache2 package
package { ['php7.2', 'php7.2-mysql']:
  require => Exec['apt-update'],        # require 'apt-update & mysql' before installing
  ensure => installed,
}

# execute 'apt-get update'
exec { 'run-php7':                    # exec resource named 'php'
  require => Package['php7.2'],
  command => '/usr/bin/php -S 0.0.0.0:8888 -t /vagrant/src &'  # command this resource will run
}
