class AddMIntervalToRefineryProducts < ActiveRecord::Migration
  def change
    add_column :refinery_products, :m_interval, :string
  end
end
