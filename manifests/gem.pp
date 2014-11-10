class jenkins_base::gem {

  package { 'fpm':
    ensure   => 'installed',
    provider => 'gem',
  }

  package { 'getopt':
    ensure   => 'installed',
    provider => 'gem',
  }

  package { 'json':
    ensure   => 'installed',
    provider => 'gem',
  }

  package { 'redis':
    ensure   => 'installed',
    provider => 'gem',
  }

}
