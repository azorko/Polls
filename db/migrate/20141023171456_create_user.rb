class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
    end
    
    add_index :users, :username, unique: true
  end
end
