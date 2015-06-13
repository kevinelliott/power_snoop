module PowerSnoop
  class Brand < PowerSnoop::Base
    class << self
      def name
        raise_must_define_method :name
      end

      def description
        raise_must_define_method :description
      end

      def website
        raise_must_define_method :website
      end
    end
  end

  module Brands
  end
end

require 'power_snoop/brands/wemo'
