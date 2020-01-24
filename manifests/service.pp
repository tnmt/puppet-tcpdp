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
    if $::operatingsystemrelease >= '7' {
      service { "tcpdp-${if}":
        ensure    => $service_ensure,
        enable    => $service_enable,
        subscribe => File["/usr/lib/systemd/system/tcpdp-${if}.service"],
      }
    }
  }
}
