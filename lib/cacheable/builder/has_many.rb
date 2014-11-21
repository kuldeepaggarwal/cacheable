module Cacheable
  module Builder
    class HasMany < Association
      def macro
        :has_many
      end

      def self.define_callbacks(model, reflection)
        super
        add_callbacks(model, reflection)
      end

      # This method adds 2 callbacks:
      # *after_save*:    This callback expires the owner cache after saving of
      # +belongs_to+ associated object.
      # *after_destroy*: This callback expires the owner cache after destroying
      # of +belongs_to+ associated object.
      def self.add_callbacks(model, reflection)
        if reflection.cache_supported_on_inverse_model?
          method = -> do
            Cacheable.clear(public_send(reflection.inverse_of.foreign_key), reflection);
            true
          end
          reflection.inverse_of_model.send :after_save, method
          reflection.inverse_of_model.send :after_destroy, method
        end
      end
    end
  end
end
