class jenkins_base::params {

  $configure_firewall = false
  $config_hash = {
    'JENKINS_ARGS' => { 'value' => '--webroot=/var/cache/jenkins/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --httpListenAddress="127.0.0.1"' }
  }
  $base_nginx = true
  $base_jenkins_host = '_'
  $base_mcollective_client = false
  $base_mcollective_username = 'jenkins'
  $base_mcollective_group = 'jenkins'
  $base_mcollective_homedir = '/var/lib/jenkins'
  $base_mcollective_certificate = [
    "puppet:///modules/${organization}_private/mcollective/public/${base_mcollective_username}.pem",
    "puppet:///modules/${organization}/mcollective/public/${base_mcollective_username}.pem",
    "puppet:///modules/common_private/mcollective/public/${base_mcollective_username}.pem",
    'puppet:///modules/mcollective_base/dummy.pem'
  ]
  $base_mcollective_private_key = [
    "puppet:///modules/${organization}_private/mcollective/private/${base_mcollective_username}.pem",
    "puppet:///modules/${organization}/mcollective/private/${base_mcollective_username}.pem",
    "puppet:///modules/common_private/mcollective/private/${base_mcollective_username}.pem",
    'puppet:///modules/mcollective_base/dummy.pem'
  ]

}
