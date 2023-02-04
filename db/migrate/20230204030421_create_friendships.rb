class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :requester_id, foreign_key: true
      t.integer :invitee_id, foreign_key: true
      t.string :status, null: false, default: 'requested'
      t.timestamps
    end
  end
end
