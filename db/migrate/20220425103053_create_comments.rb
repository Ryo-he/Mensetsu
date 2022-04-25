class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :experience_comment
      t.integer :user_id
      t.integer :experience_id

      t.timestamps
    end
  end
end
