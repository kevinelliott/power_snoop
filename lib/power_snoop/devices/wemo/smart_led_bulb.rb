module PowerSnoop
  module Devices
    module Wemo

      class SmartLEDBulb < PowerSnoop::Device
        class << self
          def brand
            PowerSnoop::Brands::Wemo
          end

          def energy_consumption_when_off
            0.5.watt
          end

          def energy_consumption_when_max
            10.watt
          end
        end

        def initialize
        end
      end

    end
  end
end
