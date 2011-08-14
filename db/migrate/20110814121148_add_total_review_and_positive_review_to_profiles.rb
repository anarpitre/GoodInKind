class AddTotalReviewAndPositiveReviewToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :total_reviews, :integer
    add_column :profiles, :positive_reviews, :integer
  end

  def self.down
    remove_column :profiles, :positive_reviews
    remove_column :profiles, :total_reviews
  end
end
