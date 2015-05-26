class CreateEquipmentPieces < ActiveRecord::Migration
  def change
    create_table :equipment_pieces do |t|
      t.string :name, :slug
      t.integer :user_id
      t.timestamps
    end
  end
end
