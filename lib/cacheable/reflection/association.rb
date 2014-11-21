module Cacheable
  module Reflection
    class Association
      attr_reader :name, :active_record, :original_name
      delegate :inverse_of, to: :original

      def initialize(name, ar)
        @original_name = name
        @name          = Cacheable::Reflection.get_name(name)
        @active_record = ar
      end

      def collection?
        false
      end

      # Returns the key which is required for storing the cache.
      def cache_key
        name.to_s
      end

      # Returns the original reflection for the cached association.
      #
      #=== Example
      # class User < AR::Base
      #   cache_has_many :posts
      # end
      #
      # # => User.reflections(:posts)
      def original
        active_record._reflections[original_name]
      end

      # Returns +true+ if association is defined on other side of Model,
      # otherwise +false+ .
      def cache_supported_on_inverse_model?
        inverse_of && inverse_of.belongs_to?
      end

      # Returns the +Model name+ of other side association's reflection,
      # if it exists otherwise +nil+.
      def inverse_of_model
        inverse_of && inverse_of.active_record
      end
    end
  end
end
