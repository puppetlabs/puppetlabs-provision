require 'spec_helper'

describe 'provision::destroy' do
  include BoltSpec::Plans

  context 'when running destroy plan for AWS cloud provider' do
    params = {
      'provider_options' => {
        'profile' => 'default',
      }
    }

    it 'destroy plan succeeds' do
      allow_any_out_message
      allow_any_out_verbose

      expect_plan('provision::terraform::destroy').be_called_times(1)
      expect(run_plan('provision::destroy', params)).to be_ok
    end
  end
end
