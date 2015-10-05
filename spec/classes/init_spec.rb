require 'spec_helper'
describe 'openhab' do
  let(:facts) { {:lsbdistid => 'Debian', :lsbdistcodename => 'jessie' , :osfamily => 'Debian' } }

  context 'with defaults for all parameters' do
    it { should contain_class('openhab') }
    it { should contain_class('openhab::install') }
    it { should contain_class('openhab::install::v1') }
    it { should contain_class('openhab::config') }
    it { should contain_class('openhab::service') }
  end

  context 'with defaults on debian' do
    it { should contain_apt__source('openhab') }
    it { should contain_package('openhab-runtime') }
    it { should contain_service('openhab') }
    it { should contain_user('openhab').with('home' => '/var/lib/openhab') }
    it { 
      should contain_openhab__module('persistence-rrd4j')
      should contain_package('openhab-addon-persistence-rrd4j')
    }
  end

  context 'without manage_repo on debian' do
    let(:params) { {:manage_repo => false } }

    it { should_not contain_apt__source('openhab') }
    it { should contain_package('openhab-runtime') }
    it { should contain_service('openhab') }
    it { should contain_user('openhab').with('home' => '/var/lib/openhab') }
  end

  context 'with module array defined' do
    let(:params) { {:modules => ['action-homematic', 'binding-homematic', 'action-pushover'] } }

    it { should contain_openhab__module('binding-homematic') }
    it { should contain_openhab__module('action-homematic') }
    it { should contain_openhab__module('action-pushover') }
    it { should contain_package('openhab-addon-action-homematic') }
    it { should contain_package('openhab-addon-binding-homematic') }
    it { should contain_package('openhab-addon-action-pushover') }
  end
end
