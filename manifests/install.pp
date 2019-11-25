# Class: tcpdp::install
# ===========================
#
# tcpdp::install install packages
class tcpdp::install(
  $version = $tcpdp::version,
) {

  package { 'libpcap': }

  package { 'tcpdp':
    provider => rpm,
    source   => "https://github.com/k1LoW/tcpdp/releases/download/v${version}/tcpdp-${version}-1.el${$::operatingsystemmajrelease}.x86_64.rpm",
    require  => Package['libpcap'],
  }

}
