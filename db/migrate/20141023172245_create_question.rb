class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :poll_id
    end
    
    add_index :questions, :poll_id
  end
end
