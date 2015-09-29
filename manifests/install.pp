# == Class: openhab::install
#
# Installs openhab
# Private class
#
#
# === Authors
#
# Hannes Schaller <admin@cyberkov.at>
#
# === Copyright
#
# Copyright 2015 Hannes Schaller, unless otherwise noted.
#
class openhab::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::openhab::manage_java {
    case $::lsbdistid {
      'Raspbian': {
        class {'::java':
          distribution          => 'jdk',
          package               => 'oracle-java8-jdk',
          java_alternative      => 'jdk-8-oracle-arm-vfp-hflt',
          java_alternative_path => '/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt/jre/bin/java',
        }
      }
      default: {
        include java
      }
    }
  }

  if $::openhab::manage_repo {
    case $::lsbdistid {
    /Ubuntu|Debian|Raspbian/: {
        include apt

        # Until now openHAB does not sign its packages.
        # Sorry that very bad hack.
        apt::conf { 'AllowUnauthenticated':
          ensure  => present,
          content => 'APT::Get::AllowUnauthenticated yes;',
        }

        apt::source { 'openhab':
          location => 'http://dl.bintray.com/openhab/apt-repo',
          release  => $::openhab::version,
          repos    => 'main',
      #    key      => {
      #      'id'     => '',
      #      'server' => 'pgp.mit.edu',
      #    },
        }
      }
      default:  {
        fail("manage_repo can only be set for supported OS'es")
      }
    }
  }

  package { 'openhab-runtime':
    ensure  => $::openhab::package_ensure,
    require => Apt::Source['openhab'],
    notify  => Service['openhab'],
  }

    package { $::openhab::modules :
    ensure => present,
    notify => Service['openhab'],
  }

  user { 'openhab':
    ensure  => present,
    groups  => [ 'dialout' ],
    require => Package['openhab-runtime'],
  }
}
