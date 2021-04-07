class ChangeTypeofStatus < ActiveRecord::Migration[6.1]
  def change
    drop_table :friendships
    create_table :friendships do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.integer :friend_id, null: false
      t.boolean :confirmed

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id, foreign_key: true
  end
end
