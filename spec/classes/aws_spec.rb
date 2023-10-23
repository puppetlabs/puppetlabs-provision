# frozen_string_literal: true

require 'spec_helper'

describe 'provision::aws' do
  let(:params) do
    {
      access_key_id: 'access_key_id',
      secret_access_key: 'secret_access_key',
      session_token: 'session_token',
      profile: 'profile',
    }
  end

  it { is_expected.to compile }

  context 'with all defaults' do
    it {
      is_expected.to contain_file('/root/.aws').with(
        'ensure' => 'directory',
        'mode'   => '0755',
      )
    }
    it {
      is_expected.to contain_file('/root/.aws/credentials').with(
        'ensure' => 'file',
        'mode'   => '0400',
      )
    }
  end
end
