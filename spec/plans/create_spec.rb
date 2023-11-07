require 'spec_helper'

describe 'provision::create' do
  include BoltSpec::Plans

  context 'when running create plan for AWS cloud provider' do
    params = {
      'subnet' => 'subnet-0128caxxxx',
      'security_group_ids' => ['sg-061352e6xxxxx'],
      'pe_server' => 'ip-10-138-1-62.eu-central-1.compute.internal',
    }

    it 'create plan succeeds' do
      allow_any_out_message
      allow_any_out_verbose

      expect_plan('provision::terraform::apply').be_called_times(1)
      expect(run_plan('provision::create', params)).to be_ok
    end
  end
end
