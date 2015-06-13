module PowerSnoop
  module Devices
    module Wemo

      class SmartLEDBulb < PowerSnoop::Device
        ENERGY_CONSUMPTION_WHEN_OFF = 0.5.watt
        ENERGY_CONSUMPTION_WHEN_MAX = 10.watt

        def initialize
          @brand = PowerSnoop::Brands::Wemo
        end
      end

    end
  end
end
