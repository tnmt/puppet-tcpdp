class tcpdp(
  $version    = '0.13.1',
  $interfaces = undef,

) {

  include tcpdp::install
  include tcpdp::config
  include tcpdp::service

}
