FactoryGirl.define do
  factory :taxonomy do
    title 'MyString'
    tags_recommendations true
    tags_measures true
    tags_sdgtargets true
    tags_users true
    allow_multiple false
  end

  trait :tags_recommendations do
    tags_recommendations false
  end

  trait :tags_users do
    tags_users false
  end

  trait :tags_sdgtargets do
    tags_sdgtargets false
  end
  trait :tags_measures do
    tags_measures false
  end
end
