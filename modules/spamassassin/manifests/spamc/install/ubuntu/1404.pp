class spamassassin::spamc::install::ubuntu::1404 (

  $spamd_peers           = '',
  $haproxy_maxconns      = '',
  $haproxy_port          = '',
  $haproxy_mode          = 'tcp',
  $haproxy_statsuser     = '',
  $haproxy_statspassword = '',

) {
    package { 'haproxy':
      ensure  => installed,
    }

  file {
    '/etc/default/haproxy':
      content  => template('spamassassin/1404-defaults.erb'),
      require  => Package['haproxy'],
      owner    => root,
      notify   => Service['haproxy'];
    '/etc/haproxy/haproxy.cfg':
      content  => template('spamassassin/1404-proxy.cfg.erb'),
      require  => Package['haproxy'],
      owner    => root,
      notify   => Service['haproxy'];
  }

  service { 'haproxy':
    hasstatus  => true,
    hasrestart => true,
  }
}
