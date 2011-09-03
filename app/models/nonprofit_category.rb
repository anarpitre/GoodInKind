class NonprofitCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :nonprofit

  validates :nonprofit_id , :presence => true
  validates :category_id, :presence => true

  after_update { |nonprofit_categories|
    # Ignore this is nonprofit is not verified
    return unless nonprofit_categories.nonprofit.is_verified?

    change_category = nonprofit_categories.category_id_change
    if(change_category)
      if(change_category[0])
        Category.decrement_counter(:nonprofit_count,change_category[0])
       end
       if(change_category[1])
        Category.increment_counter(:nonprofit_count,change_category[1])
       end
    end
  }
end
