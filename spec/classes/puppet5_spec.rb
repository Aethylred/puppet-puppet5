require 'spec_helper'

describe 'puppet5' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { should contain_class('puppet5::oscheck') }

      context "with no paramters" do
        it { should contain_class('puppet5::install').with(
          'ensure'  => 'installed',
          'version' => @package_details[os][:version],
          'package' => @package_details[os][:package],
        ) }
      end

      context "when specifying a package" do
        let :params do
          {
            :package => 'puppet-alt'
          }
        end
        it { should contain_class('puppet5::install').with(
          'ensure'  => 'installed',
          'version' => @package_details[os][:version],
          'package' => 'puppet-alt',
        ) }
      end

      context "when specifying a version" do
        let :params do
          {
            :version => '12'
          }
        end
        it { should contain_class('puppet5::install').with(
          'ensure'  => 'installed',
          'version' => '12',
          'package' => @package_details[os][:package],
        ) }
      end

      context "remove puppet with ensure => absent" do
        let :params do
          {
            :ensure => 'absent'
          }
        end
        it { should contain_class('puppet5::install').with(
          'ensure'  => 'absent',
          'version' => @package_details[os][:version],
          'package' => @package_details[os][:package],
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
          /\[Puppet5\]: parameter 'ensure' expects a value of type Boolean or Enum\['absent', 'false', 'installed', 'true'\]/
        ) }
      end
    end
  end
end
