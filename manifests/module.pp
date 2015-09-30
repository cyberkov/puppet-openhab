# Define: openhab::module
# ===========================
#
# Install the module for openhab
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
define openhab::module (
  $ensure = 'present',
) {

  case $::openhab::version {
    /^1/,default: {
        require openhab::install::v1

        package { "openhab-addon-${title}" :
        ensure => $ensure,
        notify => Class['openhab::service'],
        }
    }
    /^2/: {
        $title_real = "org.openhab.${title}"
        # move module files from repo dir to addon dir
    }
  }

}
