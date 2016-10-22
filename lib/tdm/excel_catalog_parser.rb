require 'roo'
require 'roo-xls'

module TDM
  class ExcelCatalogParser
    def initialize(source, price_quotient = 1.1, start_row = 7, category_class = 'Category', product_class = 'Product')
      @source = source
      @price_quotient = price_quotient
      @start_row = start_row
      @category = Object.const_get(category_class)
      @product = Object.const_get(product_class)
      @categories = []
      @current_category_level = 0
    end

    PATTERNS = [
      /^\d{2}\p{Punct}?\d?\s?\p{Alpha}+/, # SECOND_LEVEL_CATEGORY_PATTERN
      /^((\d{2}\.?\d{2})|(_\d{2}))/       # THIRD_LEVEL_CATEGORY_PATTERN
    ]

    def call
      category.transaction do
        book.each.with_index(1) do |row, i|
          # skip unnecessary rows
          next if i < start_row

          # check row validity
          break unless parsed_row?(row)

          # create product if product_row?
          if product_row?(row)
            find_or_build_product(row)
            next
          end

          # create category structure
          update_current_category_level(row, i)
          categories.pop(categories.size - current_category_level)
          categories << find_or_create_category(row)
        end
      end
    end

    protected

    attr_reader :source, :price_quotient, :categories, :category, :product, :start_row
    attr_accessor :current_category_level

    private

    def book
      @book ||= Roo::Spreadsheet.open(source)
    end

    def root_category_row?(index)
      cell_font = book.font(index, 2)
      cell_font && cell_font.italic? && cell_font.bold?
    end

    def second_category_row?(row)
      # NOT universal solution
      categories.size == 1 || row[1] =~ PATTERNS[0]
    end

    def third_category_row?(row)
      # NOT universal solution
      categories.size == 2 || row[1] =~ PATTERNS[1]
    end

    def category_row?(row)
      !row[0] && row[1]
    end

    def parsed_row?(row)
      row[1] || row[0]
    end

    def product_row?(row)
      row[0] && row[1]
    end

    def find_or_build_product(row)
      new_product = product.find_or_initialize_by(code: row[0])
      # # TODO: refactor
      # source = "public/original/#{pr.code[0..3]}/#{pr.code}.jpg"
      # destination = "#{pr.code[0..3]}/#{pr.code}.png"
      # if File.size?(source)
      #   `mogrify -path public/#{pr.code[0..3]} -resize 50x50 -format png #{source}`
      #   pr.update_attribute(:img_link, destination)
      # end
      # p [row]
      new_product.update_attributes(
        code: row[0],
        name: row[1],
        in_stock: parse_stock_count(row[3]),
        price: row[7].to_f * price_quotient,
        scu: row[15],
        img_link: parse_img_link(new_product, row[0]),
        category_id: categories.last.id,
        root_category_id: categories.first.id
      )
    end
    
    def find_or_create_category(row)
      parent = categories.last
      parent_id = parent ? parent.id : nil
      Category.find_or_create_by(name: row[1], parent_id: parent_id)
    end

    def parse_stock_count(value)
      value.is_a?(Float) ? value : nil
    end

    def parse_img_link(product, str)
      link = "#{product.code[0..3]}/#{product.code}.png"
      File.size?("public/#{link}") ? link : 'images/default_product.jpg'
    end
  
    def update_current_category_level(row, i)
      self.current_category_level = 
        case
        when root_category_row?(i)     then 0
        when second_category_row?(row) then 1
        when third_category_row?(row)  then 2
        else 3
        end
    end
  end
end

# # Update default img_link
# Product.where(img_link: nil).update_all(img_link: 'images/default_product.jpg')

# # Correct link png to products
# Product.all.each do |pr|
#   # source = "public/original/#{pr.code[0..3]}/#{pr.code}.jpg"
#   destination = "#{pr.code[0..3]}/#{pr.code}.png"
#   if File.size?("public/#{destination}")
#     p 'exists'
#     # `mogrify -path public/#{pr.code[0..3]} -resize 50x50 -format png #{source}`
#     pr.update_attribute(:img_link, destination)
#   end
# end; nil

# # Check unexistent links
# Product.all.each do |pr|
#   link = "#{pr.code[0..3]}/#{pr.code}.png"
#   # link = pr.img_link
#   if File.size?("public/#{link}")
#     pr.update_attribute(:img_link, link)
#   else
#     pr.update_attribute(:img_link, 'images/default_product.jpg')
#   end
# end

# # Remove unused files
# Dir.foreach('public') do |d|
#   Dir.foreach("public/#{d}") do |f|
#     if /(?<code>\w{2}\d{4}-\d{4}).png$/ =~ f
#       product = Product.find_by(code: code)
#       unless product
#         # product.update_attribute(:img_link, nil)
#         p f
#         File.delete("public/#{d}/#{f}")
#       end
#     end
#   end
# end

# # Remove links for empty/unexistent files
# Dir.foreach('public') do |d|
#     Dir.foreach("public/#{d}") do |f|
#     next unless /(?<code>\w{2}\d{4}-\d{4})/ =~ f
#     product = Product.find_by(code: code)
#     if product
#       product.update_attribute(:img_link, nil)
#       File.delete("public/#{d}/#{f}")
#     end
#   end
# end

# # Structure files
# Product.all.each do |product|
#   img_path = "public/#{product.img_link[5..-1]}"

#   next unless File.size?(img_path)

#   target_dir = "public/#{product.img_link[0..3]}"
#   Dir.mkdir(target_dir) unless File.directory?(target_dir)
#   FileUtils.mv(img_path, "public/#{product.img_link}")
# end

# # Download images from tdm server
# wget -O tmp.jpg http://31.media.tumblr.com/e1b8907c78b46099fd9611c2ab4b69ef/tumblr_n8rul3oJO91txb5tdo1_500.jpg; mv tmp.jpg $(md5sum tmp.jpg | cut -d' ' -f1).jpg

# # Product.all.each do |product|
# Product.all.each do |product|
# # Product.where(code: ).each do |product|
#   `wget -O public/#{product.code}.jpg --save-cookies cookies.txt --keep-session-cookies --user necm --password=gfhjkmytrv1 http://catalog.necm.ru/get.php?name=//FTP/%D1%84%D0%BE%D1%82%D0%BE%20%D0%B4%D0%BB%D1%8F%20%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D0%BD%D0%B5%D1%82-%D0%BC%D0%B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD%D0%B0/%D0%9F%D0%9E%20%D0%90%D0%A0%D0%A2%D0%98%D0%9A%D0%A3%D0%9B%D0%90%D0%9C/#{product.code[0..3]}/TDM-#{product.code}.jpg`
# end

# # Call parsing
# TDM::ExcelCatalogParser.new('http://www.necm.ru/download/zayavka77.xls').call

# # Remove unnecessary categories
# Category.where(name: ['Рекламные материалы', 'Товары других отечественных производителей']).destroy_all

# # Update products counter for categories
# Category.find_each { |c| c.update_attribute(:products_count, c.products.length) }
