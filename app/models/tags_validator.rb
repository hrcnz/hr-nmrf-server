class TagsValidator < ActiveModel::Validator
    def validate(record)
        if record.category_id.present?
            taxonomy_id = Category.find(record.category_id).taxonomy_id
            taxonomy = Taxonomy.find(taxonomy_id)
            tags = false;

            case record
            when RecommendationCategory
                tags = taxonomy.tags_recommendations
            when MeasureCategory
                tags = taxonomy.tags_measures
            when SdgtargetCategory
                tags = taxonomy.tags_sdgtargets
            when UserCategory
                tags = taxonomy.tags_users
            end
      
            if (!tags)
                record.errors[:category_id] << 'Categorys Taxonomy does not allow tagging'
            end
          end
    end
  end
  