class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
      #t.integer :poll_id
      #maybe add more things
    end

    add_index :responses, :user_id
    add_index :responses, :answer_choice_id
    #add_index :responses, :poll_id
  end
end
