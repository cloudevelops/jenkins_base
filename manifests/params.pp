class jenkins_base::params {

  $configure_firewall = false
  $config_hash = {
    'JENKINS_ARGS' => { 'value' => '--webroot=/var/cache/jenkins/war --httpPort=$HTTP_PORT --ajp13Port=$AJP_PORT --httpListenAddress="127.0.0.1"' }
  }
  $base_nginx = true
  $base_jenkins_host = $fqdn


}
