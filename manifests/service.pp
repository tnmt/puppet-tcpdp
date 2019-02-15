class tcpdp::service(
  $interfaces     = $tcpdp::interfaces,
  $service_ensure = $tcpdp::service_ensure,
  $service_enable = $tcpdp::service_enable,
) {

  $interfaces.each |String $if| {
    service { "tcpdp-${if}":
      ensure => $service_ensure,
      enable => $service_enable,
      subscribe => File["/usr/lib/systemd/system/tcpdp-${if}.service"],
    }
  }
}
