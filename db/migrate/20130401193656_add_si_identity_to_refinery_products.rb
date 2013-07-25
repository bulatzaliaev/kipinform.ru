class AddSiIdentityToRefineryProducts < ActiveRecord::Migration
  def change
    add_column :refinery_products, :si_identity, :string
  end
end
