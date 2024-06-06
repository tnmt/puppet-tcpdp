# Class: tcpdp
# ===========================
#
# tcpdp
class tcpdp(
  String $version                             = '0.23.9',
  Array[String] $interfaces                   = undef,
  Boolean $manage_interface_toml              = true,
  String $dumper                              = 'mysql',
  String $target                              = '3306',
  String $probe_buffer_size                   = '128MB',
  Boolean $probe_immidiate_mode               = true,
  Boolean $log_enable                         = true,
  String $log_format                          = 'json',
  Boolean $log_rotate_enable                  = true,
  String $log_rotation_time                   = 'daily',
  Integer $log_rotation_count                 = 3,
  Optional[String] $log_rotation_hook_script  = undef,
  Boolean $dump_enable                        = true,
  String  $dump_format                        = 'json',
  Boolean $dump_rotate_enable                 = true,
  String $dump_rotation_time                  = 'daily',
  Integer $dump_rotation_count                = 3,
  Optional[String] $dump_rotation_hook_script = undef,
  Enum['stopped', 'running'] $service_ensure  = 'running',
  Boolean $service_enable                     = true,
  Boolean $use_systemd                        = true,
) {

  if ($facts['os']['family'] == 'RedHat') and ($facts['os']['release']['major'] == '6') {
    $use_systemd = false
  }

  include tcpdp::install
  include tcpdp::config
  include tcpdp::service

}
