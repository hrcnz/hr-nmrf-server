require 'rails_helper'

RSpec.describe MeasureCategory, type: :model do
  it { should belong_to :measure }
  it { should belong_to :category }
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :measure_id }

  context "Validate uniqueness" do
    before { FactoryGirl.create(:measure_category) }
    it { should validate_uniqueness_of(:category_id).scoped_to(:measure_id) }
  end

  context "Validate tags option from Taxonomy" do
    it "Should create with tags allowed" do
      category = FactoryGirl.create(:category)
      measure = FactoryGirl.create(:measure)

      measure_category = MeasureCategory.new
      measure_category.category_id = category.id
      measure_category.measure_id = measure.id
      measure_category.save!
    end

    it "Should not create with tags not allowed" do
      category = FactoryGirl.create(:category)
      measure = FactoryGirl.create(:measure)
      taxonomy = FactoryGirl.create(:taxonomy, :tags_measures_not_allowed)
      category.taxonomy_id = taxonomy.id
      category.save!

      measure_category = MeasureCategory.new
      measure_category.category_id = category.id
      measure_category.measure_id = measure.id
      expect{measure_category.save!}.to raise_exception(/Categorys Taxonomy does not allow tagging/)
    end
  end
end
