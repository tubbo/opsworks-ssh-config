require "spec_helper"

module Opsworks
  module Ssh
    RSpec.describe Config do
      let :instance do
        double hostname: 'app1', private_ip: '127.0.0.1'
      end

      let :layer do
        double layer_id: '1', shortname: Config::Environment::LAYER_NAME
      end

      let :stack do
        double stack_id: '1', name: 'shadesoflight_qa'
      end

      let :client do
        double(
          describe_stacks: double(stacks: [stack]),
          describe_layers: double(layers: [layer]),
          describe_instances: double(instances: [instance])
        )
      end

      before do
        allow(Config).to receive(:opsworks).and_return(client)
      end

      it "has a version number" do
        expect(Config::VERSION).not_to be nil
      end

      it 'reads from an erb template' do
        expect(Config::TEMPLATE_PATH).to include('lib/opsworks/ssh/config/template.erb')
      end

      it 'iterates over each environment' do
        expect(subject).to respond_to(:each)
      end

      it 'outputs ssh config to the shell' do
        expect(subject.to_s).to include('Host shadesoflight_qa_app1')
        expect(subject.to_s).to include('HostName 127.0.0.1')
      end
    end
  end
end
