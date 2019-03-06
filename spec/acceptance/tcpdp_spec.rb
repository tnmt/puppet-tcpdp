
require 'spec_helper_acceptance'

describe 'stns::server class' do
  let(:manifest) do
    <<-EOS
      class { '::tcpdp': }
    EOS
  end

  it 'work without errors' do
    result = apply_manifest(manifest, acceptable_exit_codes: [0, 2], catch_failures: true)
    expect(result.exit_code).not_to eq 4
    expect(result.exit_code).not_to eq 6
  end

  it 'run a second time without changes' do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  describe package('tcpdp') do
    it { is_expected.to be_installed }
  end
end
