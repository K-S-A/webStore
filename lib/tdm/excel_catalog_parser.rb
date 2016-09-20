# # Update default img_link
# Product.where(img_link: nil).update_all(img_link: 'images/default_product.jpg')

# # Remove links for empty/unexistent files
# Dir.foreach('public') do |f|
#   next unless /(?<code>\w{2}\d{4}-\d{4})/ =~ f
#   product = Product.find_by(code: code)
#   if product
#     product.update_attribute(:img_link, nil)
#     File.delete("public/#{f}")
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

require 'roo'
require 'roo-xls'

module TDM
  class ExcelCatalogParser
    def initialize(source, start_row = 7, category_class = 'Category', product_class = 'Product')
      @source = source
      @start_row = start_row
      @category = Object.const_get(category_class)
      @product = Object.const_get(product_class)
      @categories = []
      @products = []
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
          unless parsed_row?(row)
            import_records
            break
          end

          # create product if product_row?
          if product_row?(row)
            products << find_or_build_product(row)
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

    attr_reader :source, :products, :categories, :category, :product, :start_row
    attr_accessor :current_category_level

    private

    def book
      @book ||= Roo::Spreadsheet.open(source)
    end

    def increment_category_level
      self.current_category_level += 1
    end

    def root_category_row?(index)
      cell_font = book.font(index, 2)
      cell_font.italic? && cell_font.bold? if cell_font
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
      # TODO: add category to product
      new_product = product.find_or_initialize_by(code: row[0])
      new_product.update_attributes(
        code: row[0],
        name: row[1],
        in_stock: parse_stock_count(row[3]),
        price: row[7],
        scu: row[12],
        img_link: parse_img_link(row[0]),
        category_id: categories.last.id
      )
    end
    
    def find_or_create_category(row)
      parent = categories.last
      parent_id = parent ? parent.id : nil
      Category.find_or_create_by(name: row[1], parent_id: parent_id)
    end

    def import_records
      p 'import_records'
      products.clear
    end
    
    def parse_stock_count(value)
      value.is_a?(Float) ? value : nil
    end

    def parse_img_link(str)
      "#{str[0..3]}/#{str}.jpg"
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