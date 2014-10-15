class jenkins_base::redis_cli {

  if !defined(Package['redis-tools']) {
    package {'redis-tools':
      ensure => present
    }
  }

}