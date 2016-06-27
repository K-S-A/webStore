class Product < ActiveRecord::Base
  MAX_SEARCH_COUNT = 8

  scope :exact_search, -> (name) { order(:name).where('name ILIKE ?', "%#{name}%").limit(MAX_SEARCH_COUNT) }

  scope :search, -> (name = '', ids = [], count = true) do
    trim!(name)
    name = name.blank? ? ['%%'] : name.split(/[ \-,._]+/).map { |n| "%#{n}%" }
    order(:name).where.not(id: ids)
                .where('name ILIKE ANY ( array[?] )', name)
                .limit(count ? (MAX_SEARCH_COUNT - ids.size) : nil)
  end

  private

  def self.trim!(name)
    name.gsub!(/^[\p{Punct}\p{Space}]+/, '')
  end
end
