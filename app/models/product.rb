class Product < ActiveRecord::Base
  MAX_SEARCH_COUNT = 8

  paginates_per 20

  belongs_to :category#, counter_cache: true
  has_many :order_items

  scope :exact_search, -> (name, type) { where("#{type.blank? ? 'name' : type} ILIKE '%#{name}%'") }
  scope :approx_search, -> (value) { where('name ILIKE ANY ( array[?] )', separated(value)) }
  scope :by_category, -> (category) { where(root_category_id: category) if category }

  # scope :search, -> (value, type, count = MAX_SEARCH_COUNT) do
  #     return unless value.present?
  #     type ||= 'name'
  #     trim!(value)
  #     products = exact_search(value, type).limit(count)
  #     if type == 'name'
  #       products += approx_search(separated(value))
  #         .where.not(id: products.map(&:id))
  #         .limit(count.try(:-, products.size))
  #     end

  #     products
  #   end

  class << self
  #   def search(value, type, count = MAX_SEARCH_COUNT)
  #     return unless value.present?
  #     type ||= 'name'
  #     trim!(value)
  #     products = exact_search(value, type).limit(count)
  #     if type == 'name'
  #       products += approx_search(separated(value))
  #         .where.not(id: products.map(&:id))
  #         .limit(count.try(:-, products.size))
  #     end

  #     products
  #   end

    # private

    def trim!(name)
      name.try(:gsub!, /^[\p{Punct}\p{Space}]+/, '')
    end

    def separated(name)
      name.blank? ? ['%%'] : name.split(/[ \-,._]+/).map { |n| "%#{n}%" }
    end
  end
end
