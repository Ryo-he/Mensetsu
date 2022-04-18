class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :name
      t.string :situation
      t.string :time
      t.string :format
      t.string :atomosphere
      t.string :question
      t.string :impression
      t.timestamps
    end
  end
end
