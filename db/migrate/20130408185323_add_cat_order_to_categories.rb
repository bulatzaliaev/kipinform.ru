class AddCatOrderToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :cat_order, :integer
  end
end
