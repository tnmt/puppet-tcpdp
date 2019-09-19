# Class: tcpdp::config
# ===========================
#
# tcpdp::config configures some parameters
class tcpdp::config(
  $manage_interface_toml     = $tcpdp::manage_interface_toml,
  $interfaces                = $tcpdp::interfaces,
  $dumper                    = $tcpdp::dumper,
  $probe_buffer_size         = $tcpdp::probe_buffer_size,
  $probe_immidiate_mode      = $tcpdp::probe_immidiate_mode,
  $log_enable                = $tcpdp::log_enable,
  $log_format                = $tcpdp::log_format,
  $log_rotate_enable         = $tcpdp::log_rotate_enable,
  $log_rotation_time         = $tcpdp::log_rotation_time,
  $log_rotation_count        = $tcpdp::log_rotation_count,
  $log_rotation_hook_script  = $tcpdp::log_rotation_hook_script,
  $dump_enable               = $tcpdp::dump_enable,
  $dump_format               = $tcpdp::dump_format,
  $dump_rotate_enable        = $tcpdp::dump_rotate_enable,
  $dump_rotation_time        = $tcpdp::dump_rotation_time,
  $dump_rotation_count       = $tcpdp::dump_rotation_count,
  $dump_rotation_hook_script = $tcpdp::dump_rotation_hook_script,
) {

  file { '/usr/lib64/libpcap.so.0.8':
    ensure => link,
    target => '/usr/lib64/libpcap.so.1',
  }

  file { '/etc/tcpdp':
    ensure => directory,
  }

  file { '/var/log/tcpdp':
    ensure => directory,
  }

  $interfaces.each |String $if| {
    file { "/var/log/tcpdp/${if}":
      ensure => directory,
    }

    if $manage_interface_toml {
      file { "/etc/tcpdp/${if}.toml":
        content => template('tcpdp/interface.toml'),
      }
    }

    if $::operatingsystemrelease >= '7' {
      include systemd::systemctl::daemon_reload
      file { "/usr/lib/systemd/system/tcpdp-${if}.service":
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('tcpdp/tcpdp.service'),
      }
      ~> Class['systemd::systemctl::daemon_reload']
    }

  }
}
