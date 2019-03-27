class AddComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment
      t.references :user, index: true
      t.references :movie, index: true
      
      t.timestamps
    end

    add_index :comments, [:user_id, :movie_id], unique: true
  end
end
