class AddImagesToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :image, :string
  end
end
