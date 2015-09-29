# == Class: openhab::config
#
# configs openhab
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
class openhab::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
}
