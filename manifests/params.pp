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
  $service_ensure = 'running'
  $service_enable = true
  $manage_repo = true
  $manage_java = true
  $version = '1.7.1'
  $modules = [ 'persistence-rrd4j' ]
  $git_source = undef
  $ssh_privatekey = undef
  $ssh_privatekey_file = undef
  $auto_accept_host_key = true
  $root_dir = undef

  #v2 only
  $addons_source = 'https://openhab.ci.cloudbees.com/job/openHAB2/lastSuccessfulBuild/artifact/distribution/target/distribution-2.0.0-SNAPSHOT-addons.zip'
  $runtime_source = 'https://openhab.ci.cloudbees.com/job/openHAB2/lastSuccessfulBuild/artifact/distribution/target/distribution-2.0.0-SNAPSHOT-runtime.zip'
  $demo_source = 'https://openhab.ci.cloudbees.com/job/openHAB2/lastSuccessfulBuild/artifact/distribution/target/distribution-2.0.0-SNAPSHOT-demo.zip'

}
