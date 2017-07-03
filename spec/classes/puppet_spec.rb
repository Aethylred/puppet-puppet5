require spec_helper

describe 'puppet' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

    end
  end
  context 'on an Unknown OS' do
    let :facts do
      {
        :osfamily       => 'Unknown',
        :concat_basedir => '/dne',
      }
    end
    it { should raise_error(Puppet::Error, /The puppet5 module does not support Unknown family of operating systems/) }
  end
end