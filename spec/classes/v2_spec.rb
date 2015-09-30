require 'spec_helper'
describe 'openhab' do
  let(:facts) { {:lsbdistid => 'Debian', :lsbdistcodename => 'jessie' , :osfamily => 'Debian' } }
  let(:params) { {:version => '2' } }

  context 'with defaults for all parameters' do
    it { should contain_class('openhab') }
  end

  context 'with defaults on debian' do
    it { should_not contain_apt__source('openhab') }
    it { should_not contain_apt__conf('AllowUnauthenticated') }
    it { should_not contain_package('openhab-runtime') }
    it { should contain_service('openhab') }
    it { should contain_user('openhab') }
  end

end
