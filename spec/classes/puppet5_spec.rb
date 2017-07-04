require 'spec_helper'

describe 'puppet5' do
  package_details = {
    'redhat-6-x86_64' => {
      :version => '5.0.0-1.el6',
      :package => 'puppet-agent',
    },
    'redhat-7-x86_64' => {
      :version=> '5.0.0-1.el7',
      :package => 'puppet-agent',
    },
    'centos-6-x86_64' => {
      :version=> '5.0.0-1.el6',
      :package => 'puppet-agent',
    },
    'centos-7-x86_64' => {
      :version=> '5.0.0-1.el7',
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
        it { should contain_class('puppet5::install').with(
          'ensure'  => 'installed',
          'version' => package_details[os][:version],
          'package' => package_details[os][:package],
        ) }
      end

    end
  end
end