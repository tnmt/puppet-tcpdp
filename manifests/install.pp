class tcpdp::install(
  $version = $tcpdp::version,
) {

  package { 'tcpdp':
    source => "https://github.com/k1LoW/tcpdp/releases/download/v${version}/tcpdp-${version}-1.el7.x86_64.rpm",
  }

}
