module PowerSnoop
  module Devices
    module Wemo

      class Link < PowerSnoop::Device
        attr_accessor :description, :firmware_version, :friendly_name, :mac_address, :model
        attr_accessor :manufacturer, :serial_number, :state, :upc

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
          @description      = nil
          @firmware_version = nil
          @friendly_name    = nil
          @mac_address      = nil
          @manufacturer     = nil
          @serial_number    = nil
          @state            = nil
          @upc              = nil
        end

        def to_s
          "#{friendly_name} (MAC: #{mac_address}, Serial: #{serial_number})"
        end
      end

    end
  end
end
