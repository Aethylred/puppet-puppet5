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
        it { should contain_package('puppet-agent').with(
          'ensure' => hiera.lookup('ensure_package'),
          'name'   => hirea.lookup('package')
        ) }
      end

    end
  end
end