# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :topic do
    name { Faker::Nation.capital_city }
    trait :with_image do
      image do
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'images', 'test.jpg'),
                                     'image/jpeg')
      end
    end
  end
end
