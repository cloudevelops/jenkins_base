class jenkins_base::ansible {

  sudo::conf {
    'jenkins-ansible':
      priority => 10,
      content  => "%jenkins ALL=(ansible) NOPASSWD: ALL\n";
  }

}
