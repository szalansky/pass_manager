class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.integer :user_id, :null => false
      t.string :value, :null => false
      t.datetime :created_at, :null => false
    end
  end
end
