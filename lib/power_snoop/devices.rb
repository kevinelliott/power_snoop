module PowerSnoop
  class Device < PowerSnoop::Base
    class << self
      def brand
        raise_must_define_method :website
      end

      def name
        raise_must_define_method :name
      end

      def description
        raise_must_define_method :description
      end

      def power_consumption_when_off
        raise_must_define_method :power_consumption_when_off
      end

      def power_consumption_when_max
        raise_must_define_method :power_consumption_when_max
      end

      def website
        raise_must_define_method :website
      end
    end
  end

  module Devices
  end
end

require 'power_snoop/devices/wemo'
