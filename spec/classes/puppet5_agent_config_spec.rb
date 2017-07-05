require 'spec_helper'

describe 'puppet5::agent::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { should contain_class('puppet5::oscheck') }

      context "with no paramters" do

      end

      context "remove puppet config with ensure => absent" do
        let :params do
          {
            :ensure => 'absent'
          }
        end

      end

      context "when ensure is an incorrect value" do
        let :params do
          {
            :ensure => 'anything'
          }
        end
        it { should raise_error(
          Puppet::Error,
          /\[Puppet5::Agent::Config\]: parameter 'ensure' expects a value of type Boolean or Enum\['absent', 'false', 'present', 'true'\]/
        ) }
      end
    end
  end
end
