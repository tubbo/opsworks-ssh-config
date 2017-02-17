module Opsworks
  module Ssh
    class Config
      class Environment
        LAYER_NAME = 'app'

        attr_reader :stack, :layer, :stack_id

        def initialize(stack: nil)
          @stack = stack
          @stack_id = stack.stack_id
        end

        def name
          @name ||= @stack.name.gsub(/-/, '_')
        end

        def servers
          instances.map do |instance|
            Server.new(instance: instance)
          end.select(&:active?)
        end

        private

        def layers
          Config.opsworks.describe_layers(stack_id: stack_id).layers
        end

        def layer
          layers.find do |layer|
            layer.shortname == LAYER_NAME
          end
        end

        def instances
          Config.opsworks.describe_instances(layer_id: layer.layer_id).instances
        end
      end
    end
  end
end
