class jenkins_base::sudo {

  sudo::conf {
    'jenkins-ansible':
      priority => 10,
      content  => "%jenkins ALL=(ansible) NOPASSWD: ALL\n";
  }

}
