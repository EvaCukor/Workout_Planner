class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :slug
      t.integer :user_id
      t.references :categorizeable, polymorphic: true
      t.timestamps
    end
  end
end
