class AddGosreestrNumberToRefineryProducts < ActiveRecord::Migration
  def change
    add_column :refinery_products, :gosreestr_number, :string
  end
end
