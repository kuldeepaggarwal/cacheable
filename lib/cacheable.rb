require 'cacheable/reflection'
require 'cacheable/builder'

module Cacheable
  extend ActiveSupport::Concern

  included do
    include Reflection
  end

  module ClassMethods
    # This method recieves all parameters of +has_many+ association.
    # In addition to it, it will give another method +cache_<association_name>+
    # for fetching associated records from the database.
    #
    # See Cacheable::Builder::Association#define_readers for further
    # options.
    def cache_has_many(name, scope = nil, options = {}, &extension)
      has_many name, scope, options, &extension
      reflection = Cacheable::Builder::HasMany.build(self, name)
      Cacheable::Reflection.add_reflection self, name, reflection
    end
  end

  def self.clear(*args)
    cache.delete(args)
  end

  def self.cache
    @cache_store ||= begin
      store = ActiveSupport::Cache.lookup_store(:file_store, Rails.root.join('tmp/cache'))
      store.logger = Rails.logger
      store
    end
  end
end
