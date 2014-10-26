class CreatePoll < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.integer :author_id #this is the id of our user_collumn
    end
    
    add_index :polls, :author_id
    
  end
end
