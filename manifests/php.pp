class jenkins_base::php {

  package {
    'php5-cli':
      ensure => present;
    'php5-curl':
      ensure => present;
    'php-codesniffer':
      ensure => present;
    'phpunit':
      ensure => present;
  }

}
