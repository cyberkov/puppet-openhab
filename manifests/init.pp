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
#  Whether the openhab repo should be used. As of now this is the only
#  option to install openHab with this module.
#
# * `manage_java`
#  Install java if necessary. This utilizes the puppetlabs-java module
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
#    class { 'openhab': 
#      modules => [ 
#        'openhab-addon-persistence-rrd4j',
#        'openhab-addon-binding-exec'
#      ]
#    }
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
  $package_ensure = $::openhab::params::package_ensure,
  $service_ensure = $::openhab::params::service_ensure,
  $service_enable = $::openhab::params::service_enable,
  $manage_repo = $::openhab::params::manage_repo,
  $manage_java = $::openhab::params::manage_java,
  $version = $::openhab::params::version,
  $modules = $::openhab::params::modules,
  $git_source = $::openhab::params::git_source,
  $root_dir = undef,
  $ssh_privatekey = $::openhab::params::ssh_privatekey,
  $ssh_privatekey_file = $::openhab::params::ssh_privatekey_file,
  $auto_accept_host_key = $::openhab::params::auto_accept_host_key,
) inherits openhab::params {

  if $root_dir {
    $root_dir_real = $root_dir
  } else {
    case $::openhab::version {
      /^1/,default: {
        $root_dir_real = '/var/lib/openhab'
      }
      /^2/: {
        $root_dir_real = '/opt/openhab'
      }
    }
  }

# Validations
  validate_string($package_ensure, $service_ensure, $root_dir, $version)
  validate_bool($manage_repo, $manage_java, $service_enable)
  validate_array($modules)

  class { '::openhab::install': }
  class { '::openhab::config': }
  class { '::openhab::service': }

  # Containment
  anchor { 'openhab::begin': } ->
  Class['openhab::install'] ->
  Class['openhab::config'] ~>
  Class['openhab::service'] ->
  anchor { 'openhab::end': }

}
