class Product < ActiveRecord::Base
  MAX_SEARCH_COUNT = 8

  has_many :order_items

  scope :exact_search, -> (name, type) { type == 'name' ? where('name ILIKE ?', "%#{name}%") : where("#{type}" => name) }
  scope :approx_search, -> (names) { where('name ILIKE ANY ( array[?] )', names) }
  scope :by_category, -> (category) { where(category: category) if category }

  class << self
    def search(value, type, count = MAX_SEARCH_COUNT)
      return unless value.present?
      type ||= 'name'
      trim!(value)
      products = exact_search(value, type).limit(count)
      if type == 'name'
        products += approx_search(separated(value))
          .where.not(id: products.map(&:id))
          .limit(count.try(:-, products.size))
      end

      products
    end

    private

    def trim!(name)
      name.try(:gsub!, /^[\p{Punct}\p{Space}]+/, '')
    end

    def separated(name)
      name.blank? ? ['%%'] : name.split(/[ \-,._]+/).map { |n| "%#{n}%" }
    end
  end
end
