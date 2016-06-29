module Cacheable
  extend ActiveSupport::Concern

  included do
    # relations, callbacks, validations, scopes and others...
  end

  # instance methods
  def fetch_products
    'products'
  end

  def redis_search_key(str)
    "#{controller_name.classify.downcase}:search:#{str}"
  end

  module ClassMethods
    # class methods
  end
end
