class jenkins_base::mcollective_client {

  mcollective::user { $jenkins_base::base_mcollective_username :
    username => $jenkins_base::base_mcollective_username,
    group => $jenkins_base::base_mcollective_group,
    homedir => $jenkins_base::base_mcollective_homedir,
    certificate => $jenkins_base::base_mcollective_certificate,
    private_key => $jenkins_base::base_mcollective_private_key,
  }

}
