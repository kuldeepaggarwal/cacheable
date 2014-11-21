module Cacheable
  module Reflection
    class HasMany < Association
      def collection?
        true
      end
    end
  end
end
