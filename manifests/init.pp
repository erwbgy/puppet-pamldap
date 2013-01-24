class pamldap (
  $base_dn = hiera('pamldap::base_dn'),
  $uris    = hiera('pamldap::uris'),
) {
  class { 'pamldap::config':
    base_dn => $base_dn,
    uris    => $uris,
  }
  include pamldap::install
  include pamldap::service
}
