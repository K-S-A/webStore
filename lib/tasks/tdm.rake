namespace :tdm do
  desc 'TODO'
  task import: :environment do
    TDM::ExcelCatalogParser.new('http://www.necm.ru/download/zayavka77.xls').call
    Category.where(name: ['Рекламные материалы', 'Товары других отечественных производителей']).destroy_all
  end
end
