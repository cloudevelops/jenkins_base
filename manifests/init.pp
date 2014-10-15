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
  $version                      = undef,
  $lts                          = undef,
  $repo                         = undef,
  $service_enable               = undef,
  $service_ensure               = undef,
  $config_hash                  = $jenkins_base::params::config_hash,
  $plugin_hash                  = undef,
  $configure_firewall           = $jenkins_base::params::configure_firewall,
  $install_java                 = undef,
  $proxy_host                   = undef,
  $proxy_port                   = undef,
  $cli                          = undef,
  $base_nginx                   = $jenkins_base::params::base_nginx,
  $base_jenkins_user            = undef,
  $base_jenkins_host            = $jenkins_base::params::base_jenkins_host,
  $base_mcollective_client      = $jenkins_base::params::base_mcollective_client,
  $base_mcollective_username    = $jenkins_base::params::base_mcollective_username,
  $base_mcollective_group       = $jenkins_base::params::base_mcollective_group,
  $base_mcollective_homedir     = $jenkins_base::params::base_mcollective_homedir,
  $base_mcollective_certificate = undef,
  $base_mcollective_private_key = undef,
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

  if $base_nginx {
    include jenkins_base::nginx
  }

  jenkins::plugin {
    'build-flow-plugin': ;
    'promoted-builds': ;
    'publish-over-ssh': ;
    'copyartifact': ;
    'email-ext': ;
    'email-ext-recipients-column': ;
  }

  if $base_mcollective_client {
    include jenkins_base::mcollective_client
  }

}
