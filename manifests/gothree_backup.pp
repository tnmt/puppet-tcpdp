class tcpdp::gothree_backup {

  $version  = '0.2.0'
  $revision = '6797f5d'
  $target   = "v${version}-${revision}"

  archive { "/usr/local/src/gothree-${target}.zip":
    source => "https://github.com/pyama86/gothree/releases/download/${target}/linux_amd64.zip",
    extract => true,
    extract_path => "/usr/local/bin",
    cleanup => false,
  }
  ~> file { '/usr/local/bin/gothree':
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  file { '/usr/local/bin/query_backup.sh':
    source => 'puppet:///modules/tcpdp/query_backup.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
