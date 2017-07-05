require 'spec_helper'

describe 'puppet5::install' do
  package_details = {
    'redhat-6-x86_64' => {
      :version => '5.0.0-1.el6',
      :package => 'puppet-agent',
    },
    'redhat-7-x86_64' => {
      :version => '5.0.0-1.el7',
      :package => 'puppet-agent',
    },
    'centos-6-x86_64' => {
      :version => '5.0.0-1.el6',
      :package => 'puppet-agent',
    },
    'centos-7-x86_64' => {
      :version => '5.0.0-1.el7',
      :package => 'puppet-agent',
    },
  }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { should contain_class('puppet5::oscheck') }

      context "with no paramters" do
        it { should contain_package('puppet-agent').with(
          'ensure' => package_details[os][:version],
          'name'   => package_details[os][:package],
        ) }
      end

      context "when specifying a package" do
        let :params do
          {
            :package => 'puppet-alt'
          }
        end
        it { should contain_package('puppet-agent').with(
          'ensure' => package_details[os][:version],
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
          'name'   => package_details[os][:package],
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
      end

      context "when ensure is an incorrect value" do
                let :params do
          {
            :ensure => 'anything'
          }
        end
        it { should raise_error(
          Puppet::Error,
          /\[Puppet5::Install\]: parameter 'ensure' expects a value of type Boolean or Enum\['absent', 'false', 'installed', 'true'\]/
        ) }
      end

    end
  end
end