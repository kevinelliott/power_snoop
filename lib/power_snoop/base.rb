module PowerSnoop

  class Base
    class << self
      def raise_must_define_method(sym)
        raise "you must define the method :#{sym} on your subclass"
      end
    end
  end

end
