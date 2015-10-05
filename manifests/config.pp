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

  user { 'openhab':
    ensure => present,
    home   => $::openhab::root_dir_real,
    groups => [ 'dialout' ],
  }

  if $::openhab::modules {
    ensure_resource('openhab::module', $::openhab::modules, { ensure => 'installed' })
  }

  if $::openhab::git_source {
    require 'git'

    if !defined(File["${::openhab::root_dir_real}/.ssh"]) {
      file { "${::openhab::root_dir_real}/.ssh":
        ensure => 'directory',
        owner  => 'openhab',
        group  => 'openhab',
        mode   => '0700',
      }
    }

    if !defined(File["${::openhab::root_dir_real}/.ssh/id_rsa"]) {
      file { "${::openhab::root_dir_real}/.ssh/id_rsa":
        ensure  => 'file',
        owner   => 'openhab',
        group   => 'openhab',
        mode    => '0600',
        content => $::openhab::ssh_privatekey,
        source  => $::openhab::ssh_privatekey_file,
      }
    }

    if $::openhab::auto_accept_host_key {
      file { "${::openhab::root_dir_real}/.ssh/config":
        owner   => 'openhab',
        group   => 'openhab',
        mode    => '0440',
        content => "Host *\n\tStrictHostKeyChecking no\n",
        before  => Vcsrepo[$::openhab::conf_dir_real],
      }
    }

    file { $::openhab::conf_dir_real:
      ensure => 'directory',
      owner  => 'openhab',
      group  => 'openhab',
      mode   => '0755',
      before => Vcsrepo[$::openhab::conf_dir_real],
    }

    vcsrepo { $::openhab::conf_dir_real:
      ensure   => latest,
      provider => git,
      source   => $::openhab::git_source,
      user     => 'openhab',
      revision => 'master',
      notify   => Class['openhab::service'],
    }

  }

}
