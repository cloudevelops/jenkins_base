class jenkins_base::deploy {

  $private_key = hiera('deploy::private_key')
  $public_key = hiera('deploy::public_key')
  $user = "jenkins"
  $group = "jenkins"

  file {
    "/var/lib/${user}":
      ensure => directory,
      mode   => '0600',
      owner  => $user,
      group  => $group;
    "/var/lib/${user}/.ssh":
      ensure => directory,
      mode   => '0600',
      owner  => $user;
    "/var/lib/${user}/.ssh/authorized_keys":
      ensure => present,
      source => $public_key,
      owner  => $user,
      mode   => '0600';
    "/var/lib/${user}/.ssh/id_rsa":
      ensure => present,
      source => $private_key,
      owner  => $user,
      mode   => '0600';
    "/var/lib/${user}/.ssh/config":
      ensure => present,
      source => 'puppet:///modules/deploy/ssh/config',
      owner  => $user,
      mode   => '0600';
  }

}