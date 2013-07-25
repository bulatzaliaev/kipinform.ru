class AddManufacturerToRefineryProducts < ActiveRecord::Migration
  def change
    add_column :refinery_products, :manufacturer, :string
  end
end
