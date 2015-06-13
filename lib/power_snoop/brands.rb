module PowerSnoop
  class Brand
    def name
      raise_must_define_method :name
    end

    def description
      raise_must_define_method :description
    end

    def website
      raise_must_define_method :website
    end

    def raise_must_define_method(sym)
      raise "you must define the method :#{sym} on your subclass"
    end
  end

  module Brands
  end
end
