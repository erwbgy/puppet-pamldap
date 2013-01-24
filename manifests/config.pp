class pamldap::config (
  $base_dn,
  $uris,
  $domain,
) {
  $uris_space = join($uris, ' ')
  $uris_comma = join($uris, ',')
  # defaults
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/pam.d/system-auth':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/system-auth.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/nsswitch.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/nsswitch.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/ldap.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/ldap.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { [ '/etc/pam_ldap.conf', '/etc/openldap/ldap.conf' ]:
    ensure  => link,
    target  => '/etc/ldap.conf',
    require => File['/etc/ldap.conf'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/sssd/sssd.conf':
    ensure  => present,
    mode    => '0600',
    content => template('pamldap/sssd.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/idmapd.conf':
    ensure  => present,
    mode    => '0644',
    content => template('pamldap/idmapd.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
}
