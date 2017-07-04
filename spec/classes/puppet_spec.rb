require 'spec_helper'

describe 'puppet5' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      # Initialise hiera
      let(:hiera_config) { 'spec/hiera.yaml' }
      hiera = Hiera.new()

      it { is_expected.to compile.with_all_deps }
      it { should contain_class('puppet5::oscheck') }

      context "with no paramters" do
        it { should contain_package('puppet-agent').with(
          'ensure' => hiera.lookup('ensure_package', nil, nil),
          'name'   => hirea.lookup('package', nil, nil)
        ) }
      end

    end
  end
end