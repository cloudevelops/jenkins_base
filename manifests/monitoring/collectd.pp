class jenkins_base::monitoring::collectd {

  collectd::plugin::python {'jenkins':
    module => 'jenkins',
    modulepath => '/usr/lib/collectd',
    script_source => '/usr/lib/collectd/jenkins.py'
  }

}
