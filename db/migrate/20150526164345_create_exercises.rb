class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name, :slug
      t.text :description
      t.integer :difficulty, :user_id
      t.timestamps
    end
  end
end
