class tcpdp::service(
  $interfaces = $tcpdp::interfaces,
) {

  $interfaces.each |String $if| {
    service { "tcpdp-${if}":
      ensure    => 'running',
      subscribe => File["/usr/lib/systemd/system/tcpdp-${if}.service"],
    }
  }
}
