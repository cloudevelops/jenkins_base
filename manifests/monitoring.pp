class jenkins_base::monitoring {

  if $jenkins_base::base_monitoring_sensu {
    include jenkins_base::monitoring::sensu
  }

  if $jenkins_base::base_monitoring_collectd {
    include jenkins_base::monitoring::collectd
  }

}

