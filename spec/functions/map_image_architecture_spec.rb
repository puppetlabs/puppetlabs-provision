# frozen_string_literal: true

require 'spec_helper'

describe 'provision::map_image_architecture' do
  context 'when called with arm architecture' do
    it { is_expected.to run.with_params('aws', 'arm').and_return('arm64') }
  end

  context 'when called with amd architecture' do
    it { is_expected.to run.with_params('aws', 'amd').and_return('x86_64') }
  end

  context 'when called with intel architecture' do
    it { is_expected.to run.with_params('aws', 'intel').and_return('x86_64') }
  end
end
