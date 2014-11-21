require 'cacheable/reflection/association'
require 'cacheable/reflection/has_many'

module Cacheable
  module Reflection
    extend ActiveSupport::Concern

    included do
      class_attribute :_cache_reflections
      self._cache_reflections = {}
    end

    def self.add_reflection(ar, name, reflection)
      ar._cache_reflections.merge!(name => reflection)
    end

    def self.create(macro, name, ar)
      case macro
      when :has_many
        HasMany
      else
        raise "Unsupported Macro: #{macro}"
      end.new(name, ar)
    end

    def self.get_name(name)
      :"cache_#{ name }"
    end
  end
end
