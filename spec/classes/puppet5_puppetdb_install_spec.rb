require 'spec_helper'

describe 'puppet5::puppetdb::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { should contain_class('puppet5::oscheck') }

      context "with no paramters" do
        it { should contain_package('puppetdb').with(
          'ensure' => @puppetdb_package[os][:version],
          'name'   => @puppetdb_package[os][:package],
        ) }
      end

      context "when specifying a package" do
        let :params do
          {
            :package => 'puppetdb-alt'
          }
        end
        it { should contain_package('puppetdb').with(
          'ensure' => @puppetdb_package[os][:version],
          'name'   => 'puppetdb-alt',
        ) }
      end

      context "when specifying a version" do
        let :params do
          {
            :version => '12'
          }
        end
        it { should contain_package('puppetdb').with(
          'ensure' => '12',
          'name'   => @puppetdb_package[os][:package],
        ) }
      end

      context "remove puppet with ensure => absent" do
        let :params do
          {
            :ensure => 'absent'
          }
        end
        it { should contain_package('puppetdb').with(
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
          /\[Puppet5::Puppetdb::Install\]: parameter 'ensure' expects a value of type Boolean or Enum\['absent', 'installed'\]/
        ) }
      end

    end
  end
end