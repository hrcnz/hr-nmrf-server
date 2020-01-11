FactoryGirl.define do
  factory :taxonomy do
    title 'MyString'
    tags_recommendations true
    tags_measures true
    tags_sdgtargets true
    tags_users true
    allow_multiple false
  end

  trait :tags_recommendations_not_allowed do
    tags_recommendations false
  end

  trait :tags_users_not_allowed do
    tags_users false
  end

  trait :tags_sdgtargets_not_allowed do
    tags_sdgtargets false
  end
  trait :tags_measures_not_allowed do
    tags_measures false
  end
end
