# == Class: jenkins_base
#
# Full description of class jenkins_base here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { jenkins_base:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class jenkins_base (
  $version            = undef,
  $lts                = undef,
  $repo               = undef,
  $service_enable     = undef,
  $service_ensure     = undef,
  $config_hash        = undef,
  $plugin_hash        = undef,
  $configure_firewall = undef,
  $install_java       = undef,
  $proxy_host         = undef,
  $proxy_port         = undef,
  $cli                = undef,
) inherits jenkins_base::params {

  class {'jenkins':
    version            => $version,
    lts                => $lts,
    repo               => $repo,
    service_enable     => $service_enable,
    service_ensure     => $service_ensure,
    config_hash        => $config_hash,
    plugin_hash        => $plugin_hash,
    configure_firewall => $configure_firewall,
    install_java       => $install_java,
    proxy_host         => $proxy_host,
    proxy_port         => $proxy_port,
    cli                => $cli,
  }


}
