# == Class: openhab::service
#
# services openhab
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
class openhab::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'openhab':
    ensure  => running,
    enable  => true,
    require => Package['openhab-runtime'],
  }

}
