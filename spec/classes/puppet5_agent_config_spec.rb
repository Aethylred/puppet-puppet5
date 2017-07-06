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
        it { should contain_file('puppet.conf').with(
          'ensure'  => 'file',
          'path'    => @config_files[:puppetconf],
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
        ) }
        it { should contain_file('puppet.conf').without_content(
          %r{^\[main\]$}
        )}
        it { should contain_file('puppet.conf').without_content(
          %r{^  basemodulepath = }
        )}
      end

      context "when specifying a basemodulepath" do
        let :params do
          {
            :basemodulepaths => ['/path/to/basemodule','/another/path/to/basemodule']
          }
        end
        it { should contain_file('puppet.conf').with_content(
          %r{^\[main\]$}
        )}
        it { should contain_file('puppet.conf').with_content(
          %r{^  basemodulepath = /path/to/basemodule:/another/path/to/basemodule$}
        )}
      end

      context "remove puppet config with ensure => absent" do
        let :params do
          {
            :ensure => 'absent'
          }
        end
        it { should contain_file('puppet.conf').with(
          'ensure'  => 'absent',
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
          /\[Puppet5::Agent::Config\]: parameter 'ensure' expects a value of type Boolean or Enum\['absent', 'false', 'present', 'true'\]/
        ) }
      end
    end
  end
end
