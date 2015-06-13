module PowerSnoop
  module Brands

    class Wemo < PowerSnoop::Brand
      class << self
        def name
          'WeMo'
        end

        def descriptions
          'WeMo by Belkin is a ZigBee-based home automation product suite.'
        end

        def website
          'http://www.wemothat.com/'
        end
      end
    end

  end
end
