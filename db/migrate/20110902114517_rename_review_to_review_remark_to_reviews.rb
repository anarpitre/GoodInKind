class RenameReviewToReviewRemarkToReviews < ActiveRecord::Migration
  def self.up
    rename_column :reviews, :review, :review_remark
  end

  def self.down
    rename_column :reviews, :review_remark, :review
  end
end
