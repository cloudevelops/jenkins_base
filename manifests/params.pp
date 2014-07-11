class jenkins_base::params {

  if $firewall_base::firewall_enabled {
    $configure_firewall = true
  } else {
    $configure_firewall = false
  }

}
