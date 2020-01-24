# Class: tcpdp::service
# ===========================
#
# tcpdp::service manages service
class tcpdp::service(
  $interfaces     = $tcpdp::interfaces,
  $service_ensure = $tcpdp::service_ensure,
  $service_enable = $tcpdp::service_enable,
) {

  $interfaces.each |String $if| {
    $service_file = $::operatingsystemmajrelease ? {
      '6' => "/etc/rc.d/init.d/tcpdp-${if}",
      '7' => "/usr/lib/systemd/system/tcpdp-${if}.service",
    }
    service { "tcpdp-${if}":
      ensure    => $service_ensure,
      enable    => $service_enable,
      subscribe => File[$service_file],
    }
  }
}
