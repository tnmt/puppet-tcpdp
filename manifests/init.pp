class tcpdp(
  $version        = '0.13.1',
  $interfaces     = undef,
  $gothree_backup = false,
) {

  include tcpdp::install
  include tcpdp::config
  include tcpdp::service

  if $gothree_backup {
    include tcpdp::gothree_backup
  }

}
