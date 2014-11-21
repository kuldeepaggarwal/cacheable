module Cacheable
  module Builder
    class Association

      def self.build(model, name)
        reflection = new(name).build(model)
        define_readers model, reflection
        define_callbacks model, reflection
        reflection
      end

      def build(model)
        Cacheable::Reflection.create(macro, name, model)
      end

      attr_reader :name
      def initialize(name)
        @name = name
      end

      def macro
        raise NotImplementedError
      end

      def self.define_callbacks(model, reflection)
        add_destroy_callbacks(model, reflection)
      end

      # Defines the getter methods for the association
      # class Post < ActiveRecord::Base
      #   cache_has_many :comments
      # end
      #
      # Post.first.cache_comments is defined by this method.
      #
      #=== Options
      # *force_reload*: It will clear the caches and reload the association data from database.
      #
      #=== Examples
      #
      # post = Post.last
      # p.cache_comments # => return comments from the cache.
      # p.cache_comments(true) # => clear the caches and reload it from DB.
      def self.define_readers(model, reflection)
        model.generated_association_methods.send :define_method, reflection.name do |force_reload = false|
          Cacheable.clear(id, reflection) if force_reload
          Rails.cache.fetch([id, reflection.cache_key]) do
            _result = association(reflection.original_name).reader(true)
            reflection.collection? ? _result.to_a : _result
          end
        end
      end

      def self.add_destroy_callbacks(model, reflection)
        model.after_destroy -> { Cacheable.clear(id, reflection) }
      end

      private_class_method :define_readers, :add_destroy_callbacks, :define_callbacks
    end
  end
end
