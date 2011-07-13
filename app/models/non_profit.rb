class NonProfit < ActiveRecord::Base
  
  has_many :non_profit_categories
  has_many :categories, :through => :non_profit_categories
  validates :name, :presence => true,:uniqueness => true
  validates :EIN,  :presence => true
  validates :description, :presence => true
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/gif"]
  validates_attachment_size  :photo, :less_than => 2.megabytes

  has_attached_file :document1 
  has_attached_file :document2
  has_attached_file :photo,
    :styles => {
    :thumb=> "100x100#",
    :small  => "400x400>" }
end
