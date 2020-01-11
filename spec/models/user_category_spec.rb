require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  it { should belong_to :user }
  it { should belong_to :category }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:category_id) }

  context "Validate uniqueness" do
    before do 
      FactoryGirl.create(:user_category)
      FactoryGirl.create(:category)
    end
    it { should validate_uniqueness_of(:user_id).scoped_to(:category_id) }
  end

  context "Validate tags option from Taxonomy" do
    it "Should create with tags allowed" do
      category = FactoryGirl.create(:category)
      user = FactoryGirl.create(:user)

      user_category = UserCategory.new
      user_category.category_id = category.id
      user_category.user_id = user.id
      user_category.save!
    end

    it "Should not create with tags not allowed" do
      category = FactoryGirl.create(:category)
      user = FactoryGirl.create(:user)
      taxonomy = FactoryGirl.create(:taxonomy, :tags_users_not_allowed)
      category.taxonomy_id = taxonomy.id
      category.save!

      user_category = UserCategory.new
      user_category.category_id = category.id
      user_category.user_id = user.id
      expect{user_category.save!}.to raise_exception(/Categorys Taxonomy does not allow tagging/)
    end
  end
end
