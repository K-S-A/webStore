FactoryGirl.define do
  factory :product do
    name "MyString"
    img_link { Faker::Placeholdit.image }
  end
end
