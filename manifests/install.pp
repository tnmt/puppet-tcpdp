# Class: tcpdp::install
# ===========================
#
# tcpdp::install install packages
class tcpdp::install(
  $version = $tcpdp::version,
) {

  package { 'libpcap': }

  $package_version = "${version}-1.el${$::operatingsystemmajrelease}"
  package { 'tcpdp':
    ensure   => $package_version,
    provider => rpm,
    source   => "https://github.com/k1LoW/tcpdp/releases/download/v${version}/tcpdp-${package_version}.x86_64.rpm",
    require  => Package['libpcap'],
  }

}
