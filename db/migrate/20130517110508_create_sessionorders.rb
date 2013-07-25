class CreateSessionorders < ActiveRecord::Migration
  def change
    create_table :sessionorders do |t|
      t.text :order

      t.timestamps
    end
  end
end
