# frozen_string_literal: true

require 'spec_helper'

describe 'provision::map_instance_type' do
  context 'when called with aws cloud provider' do
    it { is_expected.to run.with_params('aws', 'small', 'intel').and_return('t3.small') }
    it { is_expected.to run.with_params('aws', 'micro', 'intel').and_return('t3.micro') }
    it { is_expected.to run.with_params('aws', 'large', 'intel').and_return('t3.large') }

    it { is_expected.to run.with_params('aws', 'small', 'arm').and_return('t4g.small') }
    it { is_expected.to run.with_params('aws', 'micro', 'arm').and_return('t4g.micro') }
    it { is_expected.to run.with_params('aws', 'large', 'arm').and_return('t4g.large') }

    it { is_expected.to run.with_params('aws', 'small', 'amd').and_return('t3a.small') }
    it { is_expected.to run.with_params('aws', 'micro', 'amd').and_return('t3a.micro') }
    it { is_expected.to run.with_params('aws', 'large', 'amd').and_return('t3a.large') }
  end
end
