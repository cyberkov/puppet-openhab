require 'spec_helper_acceptance'

describe 'openhab class' do

  context 'default parameters (v2)' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'openhab': 
        version => '2'
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/opt/openhab/start.sh') do
      it { is_expected.to be_file }
    end

    describe service('openhab') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end