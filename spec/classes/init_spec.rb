require 'spec_helper'

describe 'provision' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      if facts[:os]['family'] == 'RedHat'
        it { is_expected.to contain_yumrepo('HashiCorp Terraform') }
      end
      it { is_expected.to contain_package('terraform') }
    end
  end
end
