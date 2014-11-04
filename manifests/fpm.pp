class jenkins_base::fpm {

  package { 'fpm':
    ensure   => 'installed',
    provider => 'gem',
  }

}
