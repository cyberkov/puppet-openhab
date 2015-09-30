# Class: openhab
# ===========================
#
# Default parameters for openhab class
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
class openhab::params {
  $package_ensure = 'present'
  $manage_repo = true
  $manage_java = true
  $version = 1
  $modules = []

  #URLs:
  # https://openhab.ci.cloudbees.com/job/openHAB2/lastSuccessfulBuild/artifact/distribution/target/distribution-2.0.0-SNAPSHOT-addons.zip
  # 
  # https://openhab.ci.cloudbees.com/job/openHAB2/lastSuccessfulBuild/artifact/distribution/target/distribution-2.0.0-SNAPSHOT-runtime.zip
}
