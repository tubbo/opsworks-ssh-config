require 'erb'
require 'aws-sdk'

require 'opsworks/ssh/config/version'
require 'opsworks/ssh/config/environment'
require 'opsworks/ssh/config/server'

module Opsworks
  module Ssh
    class Config
      TEMPLATE_PATH = File.expand_path('./config/template.erb', __dir__)

      def initialize
        @source = File.read TEMPLATE_PATH
        @template = ERB.new @source
      end

      def self.opsworks
        @opsworks ||= Aws::OpsWorks::Client.new
      end

      def each
        raise "No environments found in OpsWorks account" unless environments.any?
        environments.each do |environment|
          environment.servers.each do |server|
            yield "#{environment.name}_#{server.name}", server.ip
          end
        end
      end

      def to_s
        @template.result(binding)
      end

      protected

      def environments
        self.class.opsworks.describe_stacks.stacks.map do |stack|
          Environment.new(stack: stack)
        end.reject { |env| env.name =~ /old/ }
      end
    end
  end
end
