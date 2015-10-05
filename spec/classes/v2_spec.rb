require 'spec_helper'
describe 'openhab' do
  let(:facts) { {:lsbdistid => 'Debian', :lsbdistcodename => 'jessie' , :osfamily => 'Debian' } }
  let(:params) { {:version => '2' } }

  context 'with defaults for all parameters (v2)' do
    it { should contain_class('openhab') }
    it { should contain_class('openhab::install') }
    it { should contain_class('openhab::install::v2') }
    it { should contain_class('openhab::config') }
    it { should contain_class('openhab::service') }
  end

  context 'with defaults on debian' do
    it { should_not contain_apt__source('openhab') }
    it { should_not contain_package('openhab-runtime') }
    it { should contain_service('openhab') }
    it { should contain_user('openhab').with('home' => '/opt/openhab') }
    it { should contain_file('/opt/openhab').with( 'ensure' => 'directory') }
  end

  context 'with gitrepo to custom path' do
    let(:params) { {
      :version => '2',
      :root_dir => '/home/openhab',
      :git_source => 'git@git.example.com:openhab.git',
      :ssh_privatekey => 'fookey',
      :modules => [ 'binding.homematic', 'persistence.mqtt', 'action.pushover' ],
    } }
    
    it { should contain_file('/home/openhab').with( 'ensure' => 'directory') }
    it { should contain_vcsrepo('/home/openhab/conf').with( 'source' => 'git@git.example.com:openhab.git', 'ensure' => 'latest') }
    it {
      should contain_file('/home/openhab/.ssh')
      should contain_file('/home/openhab/.ssh/id_rsa').with( 'content' => 'fookey')
    }
    it { should contain_user('openhab').with('home' => '/home/openhab') }
    it { 
      should contain_openhab__module('binding.homematic') 
      should contain_openhab__module('persistence.mqtt') 
      should contain_openhab__module('action.pushover')
    }

  end


end
