class Product < ActiveRecord::Base
  MAX_SEARCH_COUNT = 8

  scope :exact_search, -> (name) { order(:name).where('name ILIKE ?', "%#{name}%") }
  scope :approx_search, -> (names) { order(:name).where('name ILIKE ANY ( array[?] )', names) }

  class << self
    def search(name, count = MAX_SEARCH_COUNT)
      trim!(name)
      products = exact_search(name).limit(count)
      products += approx_search(separated(name))
        .where.not(id: products.map(&:id))
        .limit(count.try(:-, products.size))
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
