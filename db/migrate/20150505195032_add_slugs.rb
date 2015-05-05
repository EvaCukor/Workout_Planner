class AddSlugs < ActiveRecord::Migration
  def change
    add_column :exercises, :slug, :string
    add_column :categories, :slug, :string
    add_column :equipment_pieces, :slug, :string
  end
end
