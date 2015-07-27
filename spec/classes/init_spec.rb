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
    it { should contain_package('openhab-runtime') }
    it { should contain_service('openhab') }
    it { should contain_user('openhab') }
  end

  context 'with module array defined' do
    let(:params) { {:modules => ['openhab-addon-action-homematic', 'openhab-addon-action-pushover'] } }

    it { 
      should contain_package('openhab-addon-action-homematic')
      should contain_package('openhab-addon-action-pushover')
    }
  end
end
