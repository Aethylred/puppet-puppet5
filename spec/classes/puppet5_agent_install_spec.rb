require 'spec_helper'

describe 'puppet5::agent::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { should contain_class('puppet5::oscheck') }

      context "with no paramters" do
        it { should contain_package('puppet-agent').with(
          'ensure' => @agent_package[os][:version],
          'name'   => @agent_package[os][:package],
        ) }
        it { should contain_file('base').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:base],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('cert_requests').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:cert_requests],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('certs').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:certs],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('code').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:code],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('environments').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:environments],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('mcollective').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:mcollective],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('modules').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:modules],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('private_certs').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:private_certs],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0750'
        ) }
        it { should contain_file('private_keys').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:private_keys],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0750'
        ) }
        it { should contain_file('public_keys').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:public_keys],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('puppet').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:puppet],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('pxp-agent').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:pxp_agent],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('pxp_modules').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:pxp_modules],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0755'
        ) }
        it { should contain_file('ssl').with(
          'ensure' => 'directory',
          'path'   => @agent_directories[:ssl],
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0771'
        ) }
      end

      context "when specifying a package" do
        let :params do
          {
            :package => 'puppet-alt'
          }
        end
        it { should contain_package('puppet-agent').with(
          'ensure' => @agent_package[os][:version],
          'name'   => 'puppet-alt',
        ) }
      end

      context "when specifying a version" do
        let :params do
          {
            :version => '12'
          }
        end
        it { should contain_package('puppet-agent').with(
          'ensure' => '12',
          'name'   => @agent_package[os][:package],
        ) }
      end

      context "remove puppet with ensure => absent" do
        let :params do
          {
            :ensure => 'absent'
          }
        end
        it { should contain_package('puppet-agent').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('base').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('cert_requests').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('certs').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('code').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('environments').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('mcollective').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('modules').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('private_certs').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('private_keys').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('public_keys').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('pxp-agent').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('pxp_modules').with(
          'ensure' => 'absent',
        ) }
        it { should contain_file('ssl').with(
          'ensure' => 'absent',
        ) }
      end

      context "when ensure is an incorrect value" do
                let :params do
          {
            :ensure => 'anything'
          }
        end
        it { should raise_error(
          Puppet::Error,
          /\[Puppet5::Agent::Install\]: parameter 'ensure' expects a value of type Boolean or Enum\['absent', 'installed'\]/
        ) }
      end

    end
  end
end