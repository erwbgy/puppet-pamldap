class pamldap (
  $base_dn = hiera('pamldap::base_dn'),
  $domain  = hiera('pamldap::domain'),
  $uris    = hiera('pamldap::uris'),
) {
  class { 'pamldap::config':
    base_dn => $base_dn,
    domain  => $domain,
    uris    => $uris,
  }
  include pamldap::install
  include pamldap::service
}
