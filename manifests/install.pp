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

  case $::openhab::version {
    1: {
      class {'openhab::install::v1': }
    }
    2: {
      class {'openhab::install::v2': }
    }
  }
      
  user { 'openhab':
    ensure => present,
    groups => [ 'dialout' ],
  }
}
