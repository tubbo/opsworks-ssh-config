module Opsworks
  module Ssh
    class Config
      class Server
        def initialize(instance: nil)
          @instance = instance
        end

        def name
          @instance.hostname
        end

        def ip
          @instance.private_ip
        end

        def active?
          !ip.nil?
        end
      end
    end
  end
end
