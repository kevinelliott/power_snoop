module PowerSnoop
  module Devices
    module Wemo

      class SmartLEDBulb < PowerSnoop::Device
        class << self
          def brand
            PowerSnoop::Brands::Wemo
          end

          def consumption_by_core
            0.5.watt
          end

          def consumption_by_light
            9.5.watt
          end

          def consumption_when_at_dim(value = 1)
            current_consumption_by_light = if value >= dim_min && value <= dim_max
              dim_percent = (value / dim_max.to_f).round(2)
              consumption_by_light * dim_percent
            else
              0.watt
            end
            consumption_by_core + current_consumption_by_light
          end

          def consumption_when_off
            consumption_by_core
          end

          def consumption_when_max
            consumption_by_core + consumption_by_light
          end

          def dim_min
            1
          end

          def dim_max
            255
          end

          def website
            'http://www.belkin.com/us/F7C033/p/P-F7C033/'
          end
        end

        def initialize
        end
      end

    end
  end
end
