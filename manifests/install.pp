# Class: tcpdp::install
# ===========================
#
# tcpdp::install install packages
class tcpdp::install(
  $version = $tcpdp::version,
) {

  $package_version = "${version}-1"
  case $facts['os']['family'] {
    'RedHat': {
      $require_package = "libpcap"
      $package_ensure = $package_version
      $package_provider = "rpm"
      $package_suffix = "rpm"
    }
    'Debian': {
      $require_package = "libpcap0.8"
      $package_ensure = "1:${version}"
      $package_provider = "apt"
      $package_suffix = "deb"
    }
    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }

  archive { "/tmp/tcpdp-${version}.${package_suffix}":
    ensure => present,
    source => "https://github.com/k1LoW/tcpdp/releases/download/v${version}/tcpdp_${package_version}_amd64.${package_suffix}",
  }

  package { $require_package: }

  package { 'tcpdp':
    ensure   => $package_ensure,
    provider => $package_provider,
    source   => "/tmp/tcpdp-${version}.${package_suffix}",
    require  => [
      Package[$require_package],
      Archive["/tmp/tcpdp-${version}.${package_suffix}"],
    ]
  }

}
