class Category < ActiveRecord::Base
  attr_accessible :parent_id, :title, :cat_order
 # attr_reader :id
  acts_as_nested_set
  has_many :products, :class_name => "::Refinery::Products::Product"
end
