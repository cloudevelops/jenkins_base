class jenkins_base::mcollective_client {

  if $jenkins_base::base_mcollective_certificate {
    $base_mcollective_certificate_real = $jenkins_base::base_mcollective_certificate
  } else {
    $base_mcollective_certificate_real = [
      "puppet:///modules/${organization}_private/mcollective/public/${jenkins_base::base_mcollective_username}.pem",
      "puppet:///modules/${organization}/mcollective/public/${jenkins_base::base_mcollective_username}.pem",
      "puppet:///modules/common_private/mcollective/public/${jenkins_base::base_mcollective_username}.pem",
      'puppet:///modules/mcollective_base/dummy.pem'
    ]
  }

  if $jenkins_base::base_mcollective_private_key {
    $base_mcollective_private_key_real = $jenkins_base::base_mcollective_private_key
  } else {
    $base_mcollective_private_key_real = [
      "puppet:///modules/${organization}_private/mcollective/private/${jenkins_base::base_mcollective_username}.pem",
      "puppet:///modules/${organization}/mcollective/private/${jenkins_base::base_mcollective_username}.pem",
      "puppet:///modules/common_private/mcollective/private/${jenkins_base::base_mcollective_username}.pem",
      'puppet:///modules/mcollective_base/dummy.pem'
    ]
  }

  mcollective::user { $jenkins_base::base_mcollective_username :
    username => $jenkins_base::base_mcollective_username,
    group => $jenkins_base::base_mcollective_group,
    homedir => $jenkins_base::base_mcollective_homedir,
    certificate => $base_mcollective_certificate_real,
    private_key => $base_mcollective_private_key_real,
  }

}
