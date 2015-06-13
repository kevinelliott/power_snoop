module PowerSnoop
  class Device << PowerSnoop::Base
    class << self
      def brand
        raise_must_define_method :website
      end
    end
  end

  module Devices
  end
end

require 'power_snoop/devices/wemo'
