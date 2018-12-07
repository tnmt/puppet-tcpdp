class tcpdp::config(
  $interfaces                = $tcpdp::interfaces,
  $log_rotation_hook_script  = $tcpdp::log_rotation_hook_script,
  $dump_rotation_hook_script = $tcpdp::dump_rotation_hook_script,
) {

  file { '/usr/lib64/libpcap.so.0.8':
    ensure => link,
    target => '/usr/lib64/libpcap.so.1',
  }

  file { '/var/run/tcpdp':
    ensure => directory,
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

    file { "/etc/tcpdp/${if}.toml":
      content => template('tcpdp/interface.toml'),
    }

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
