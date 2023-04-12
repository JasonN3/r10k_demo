# frozen_string_literal: true

require 'spec_helper'

describe 'firewall::masquerade' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'interfaces' => ['eth0']
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
