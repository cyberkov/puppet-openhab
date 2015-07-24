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
# Variables
# ----------
#
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
