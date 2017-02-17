require "spec_helper"

module Opsworks
  module Ssh
    class Config
      RSpec.describe Environment do
        let :client do
          double describe_instances: [instance]
        end

        let :instance do
          double hostname: 'test', private_ip: '127.0.0.1'
        end

        let :stack do
          double stack_id: '1', name: 'shadesoflight_test'
        end

        let :layer do
          double layer_id: '1', stack_id: stack.stack_id, shortname: Environment::LAYER_NAME
        end

        before do
          allow(client).to receive(:describe_instances).with(layer_id: '1').and_return(
            double(instances: [instance])
          )
          allow(client).to receive(:describe_layers).with(stack_id: '1').and_return(
            double(layers: [layer])
          )
          allow(Config).to receive(:opsworks).and_return(client)
        end

        subject :env do
          described_class.new stack: stack
        end

        it 'uses underscored stack name as its name' do
          expect(env.name).to eq('shadesoflight_test')
        end

        it 'enumerates through all active servers' do
          expect(env.servers).to be_any
          expect(env.servers.first).to be_a(Server)
          expect(env.servers.all? { |s| s.active? }).to eq(true)
        end

        it 'searches app layer only' do
          expect(env.send(:layer)).not_to be_nil
        end

        it 'enumerates through app layers' do
          expect(env.send(:layers)).to be_any
          expect(env.send(:layers)).to include(layer)
        end

        it 'enumerates through layer instances' do
          expect(env.send(:instances)).to be_any
        end
      end
    end
  end
end
