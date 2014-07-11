class jenkins_base::params {

  $configure_firewall = false
  $config_hash = {
    'HTTP_HOST' => { 'value' => '127.0.0.1' }
  }
  $base_nginx = true
  $base_jenkins_host = $fqdn


}
