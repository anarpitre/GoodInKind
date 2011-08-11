class ResourceCategory < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :category
end
