require 'rails_helper'

RSpec.describe SdgtargetCategory, type: :model do
  it { should belong_to :sdgtarget }
  it { should belong_to :category }
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :sdgtarget_id }

  context "Validate tags option from Taxonomy" do
    it "Should create with tags allowed" do
      category = FactoryGirl.create(:category)
      sdg_target = FactoryGirl.create(:sdgtarget)

      sdg_target_category = SdgtargetCategory.new
      sdg_target_category.category_id = category.id
      sdg_target_category.sdgtarget_id = sdg_target.id
      sdg_target_category.save!
    end

    it "Should not create with tags not allowed" do
      category = FactoryGirl.create(:category)
      sdg_target = FactoryGirl.create(:sdgtarget)
      taxonomy = FactoryGirl.create(:taxonomy, :tags_sdgtargets)
      category.taxonomy_id = taxonomy.id
      category.save!

      sdg_target_category = SdgtargetCategory.new
      sdg_target_category.category_id = category.id
      sdg_target_category.sdgtarget_id = sdg_target.id
      expect{sdg_target_category.save!}.to raise_exception(/Categorys Taxonomy does not allow tagging/)
    end
  end
end
