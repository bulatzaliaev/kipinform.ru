class AddUsageToRefineryProducts < ActiveRecord::Migration
  def change
    add_column :refinery_products, :usage, :text
  end
end
