class jenkins_base::nginx {

  include nginx_base

  if $jenkins_base::base_jenkins_user {
    htpasswd_base::user { '/etc/nginx/jenkins':
      user => $jenkins_base::base_jenkins_user,
      owner => 'www-data',
    }

    $auth_cfg = {
      'auth_basic' => '"Authorization Required"',
      'auth_basic_user_file' => 'jenkins'
    }

  } else {
    $auth_cfg = {}
  }

  nginx::resource::vhost { 'jenkins':
    listen_port => 80,
    server_name => split($jenkins_base::base_jenkins_host, ','),
#    www_root => '/usr/share/jenkins3',
    use_default_location => false,
    vhost_cfg_append => $auth_cfg,
  }

  nginx::resource::location { 'default':
    location => '/',
    vhost => 'jenkins',
    index_files => [],
    proxy => 'http://127.0.0.1:8080',
    location_cfg_prepend => $auth_cfg,
  }

}
