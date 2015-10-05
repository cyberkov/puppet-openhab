# == Class: openhab::install::v1
#
# Installs openhab v1
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
class openhab::install::v1 {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::openhab::manage_repo {
    case $::lsbdistid {
      /Ubuntu|Debian|Raspbian/: {
        include apt

        apt::source { 'openhab':
          location => 'http://dl.bintray.com/openhab/apt-repo',
          release  => $::openhab::version,
          repos    => 'main',
          key      => 'EDB7D0304E2FCAF629DF1163075721F6A224060A',
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

}
