# == Class: openhab::install::v2
#
# Installs openhab v2
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
class openhab::install::v2 {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $::openhab::install_method {
    'archive',default: {
      archive { 'openhab-runtime':
        ensure   => 'present',
        checksum => false,
        root_dir => 'bla',
        target   => $::openhab::root_dir,
        url      => $::openhab::runtime_source,
      }

      archive { 'openhab-addons':
        ensure   => 'present',
        checksum => false,
        root_dir => 'bla',
        target   => $::openhab::addon_repo_dir,
        url      => $::openhab::addons_source,
      }
    }
  }

}
