module PowerSnoop
  module Devices
    module Wemo

      class Link < PowerSnoop::Device
        attr_accessor :firmware_version, :mac_address, :serial_number

        class << self
          def brand
            PowerSnoop::Brands::Wemo
          end

          def consumption_by_core
            0.5.watt
          end

          def consumption_by_light
            2.watt
          end

          def consumption_when_off
            consumption_by_core
          end

          def consumption_when_max
            consumption_by_core + consumption_by_light
          end

          def upnp_device_type
            'urn:Belkin:device:bridge:1'
          end

          def website
            'http://www.belkin.com/us/F5Z0489-Belkin/p/P-F5Z0489/'
          end
        end

        def initialize
          @firmware_version = nil
          @mac_address = nil
          @serial_number = nil
        end
      end

    end
  end
end
