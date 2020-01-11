require 'rails_helper'

RSpec.describe RecommendationCategory, type: :model do
  it { should belong_to :recommendation }
  it { should belong_to :category }
  it { should validate_presence_of(:recommendation_id) }
  it { should validate_presence_of(:category_id) }

  context "Validate uniqueness" do
    before { FactoryGirl.create(:recommendation_category) }
    it { should validate_uniqueness_of(:category_id).scoped_to(:recommendation_id) }
  end

  context "Validate tags option from Taxonomy" do
    it "Should create with tags allowed" do
      category = FactoryGirl.create(:category)
      recommendation = FactoryGirl.create(:recommendation)

      recommendation_category = RecommendationCategory.new
      recommendation_category.category_id = category.id
      recommendation_category.recommendation_id = recommendation.id
      recommendation_category.save!
    end

    it "Should not create with tags not allowed" do
      category = FactoryGirl.create(:category)
      recommendation = FactoryGirl.create(:recommendation)
      taxonomy = FactoryGirl.create(:taxonomy, :tags_recommendations_not_allowed)
      category.taxonomy_id = taxonomy.id
      category.save!

      recommendation_category = RecommendationCategory.new
      recommendation_category.category_id = category.id
      recommendation_category.recommendation_id = recommendation.id
      expect{recommendation_category.save!}.to raise_exception(/Categorys Taxonomy does not allow tagging/)
    end
  end
end
