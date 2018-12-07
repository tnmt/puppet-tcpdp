class tcpdp(
  $version                   = '0.13.1',
  $interfaces                = undef,
  $log_rotation_hook_script  = undef,
  $dump_rotation_hook_script = undef,
) {

  include tcpdp::install
  include tcpdp::config
  include tcpdp::service

}
