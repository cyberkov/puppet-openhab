require 'spec_helper'
describe 'openhab' do
  let(:facts) { {:lsbdistid => 'Debian', :osfamily => 'Debian' } }

  context 'with defaults for all parameters' do
    it { should contain_class('openhab') }
  end

  context 'with defaults on debian' do
    let(:params) { {:manage_repo => true } }
    let(:facts) { {:lsbdistid => 'Debian', :osfamily => 'Debian' } }

    it { should contain_apt__source('openhab') }

  end
end
