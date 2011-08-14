class AddTotalReviewAndPositiveReviewToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :total_reviews, :integer
    add_column :services, :positive_reviews, :integer
  end

  def self.down
    remove_column :services, :positive_reviews
    remove_column :services, :total_reviews
  end
end
