require 'beaker-pe'
require 'beaker-puppet'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'beaker/i18n_helper'
require 'beaker-task_helper'

run_puppet_install_helper
configure_type_defaults_on(hosts)
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ %r{pe}i
install_module_on(hosts)
install_module_dependencies_on(hosts)

RSpec.configure do |_c|
  hosts.each do |host|
    # This will be removed, this is temporary to test localisation.
    if (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') &&
       (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5') &&
        Gem::Version.new(puppet_version) < Gem::Version.new('5.2.0'))
      on(host, 'mkdir /opt/puppetlabs/puppet/share/locale/ja')
      on(host, 'touch /opt/puppetlabs/puppet/share/locale/ja/puppet.po')
    end
    # Required for binding tests.
    if fact('osfamily') == 'RedHat'
      if fact('operatingsystemmajrelease') =~ %r{7} || fact('operatingsystem') =~ %r{Fedora}
        shell('yum install -y bzip2')
      end
    end
  end
end

def idempotent_apply(hosts, manifest, opts = {}, &block)
  block_on hosts, opts do |host|
    file_path = host.tmpfile('apply_manifest.pp')
    create_remote_file(host, file_path, manifest + "\n")

    puppet_apply_opts = { :verbose => nil, 'detailed-exitcodes' => nil }
    on_options = { acceptable_exit_codes: [0, 2] }
    on host, puppet('apply', file_path, puppet_apply_opts), on_options, &block
    puppet_apply_opts2 = { :verbose => nil, 'detailed-exitcodes' => nil }
    on_options2 = { acceptable_exit_codes: [0] }
    on host, puppet('apply', file_path, puppet_apply_opts2), on_options2, &block
  end
end
