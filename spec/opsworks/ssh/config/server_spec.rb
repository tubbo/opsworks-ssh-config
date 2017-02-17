require "spec_helper"

module Opsworks
  module Ssh
    class Config
      RSpec.describe Server do
        let :instance do
          double hostname: 'app1', private_ip: '10.10.10.321'
        end

        subject :server do
          described_class.new instance: instance
        end

        it 'returns the hostname as the name' do
          expect(server.name).to eq(instance.hostname)
        end

        it 'returns the private ip address' do
          expect(server.ip).to eq(instance.private_ip)
        end

        it 'is active when it has an ip' do
          expect(server).to be_active
        end

        it 'is not active unless it has an ip' do
          allow(instance).to receive(:private_ip).and_return nil
          expect(server).not_to be_active
        end
      end
    end
  end
end
