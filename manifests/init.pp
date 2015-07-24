# Class: openhab
# ===========================
#
# Manage and install openHAB
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `package_ensure`
#  default: present
#  Install the package
#
# * `manage_repo`
#
# * `modules`
#  Array of modules, that need to be installed
#
# Variables
# ----------
#
# In your hiera config you need to define an array with
# the needed modules for openHAB:
# openhab::modules:
#   - openhab-addon-action-homematic
#   - openhab-addon-action-pushover
#   - openhab-addon-action-xbmc
#   - openhab-addon-binding-astro
#   - openhab-addon-binding-cups
#   - openhab-addon-binding-exec
#   - openhab-addon-binding-homematic
#   - openhab-addon-binding-mqtt
#   - openhab-addon-binding-mqttitude
#   - openhab-addon-binding-networkhealth
#   - openhab-addon-binding-rfxcom
#   - openhab-addon-binding-weather
#   - openhab-addon-binding-xbmc
#   - openhab-addon-io-serial
#   - openhab-addon-persistence-mqtt
#   - openhab-addon-persistence-mysql
#   - openhab-addon-persistence-rrd4j
#
# Examples
# --------
#
# @example
#    class { 'openhab': }
#
# Authors
# -------
#
# Hannes Schaller <admin@cyberkov.at>
#
# Copyright
# ---------
#
# Copyright 2015 Hannes Schaller, unless otherwise noted.
#
class openhab (
  $package_ensure = 'present',
  $manage_repo = true,
  $version = 'stable',
  $modules = []
){

# Validations
  validate_string($package_ensure)
  validate_bool($manage_repo)
  validate_string($version)
  validate_array($modules)

  if $manage_repo {
    case $::lsbdistid {
    /Ubuntu|Debian/: {
        apt::source { 'openhab':
          location => 'http://dl.bintray.com/openhab/apt-repo',
          release  => $version,
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
    ensure => $package_ensure,
    notify => Service['openhab'],
  }

  package { $modules :
    ensure => present,
    notify => Service['openhab'],
  }

  user { 'openhab':
    ensure  => present,
    groups  => [ 'dialout' ],
    require => Package['openhab-runtime'],
  }

  service { 'openhab':
    ensure  => running,
    enable  => true,
    require => Package['openhab-runtime']
  }



}
