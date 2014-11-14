class jenkins_base::monitoring::sensu {

  sensu_base::check { 'check_jenkins_process_status':
    command => "/etc/sensu/plugins/jenkins/check-jenkins-process-status.rb",
    standalone => true,
  }

}

