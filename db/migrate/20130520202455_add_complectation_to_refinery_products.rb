class AddComplectationToRefineryProducts < ActiveRecord::Migration
  def change
    add_column :refinery_products, :complectation, :text
  end
end
