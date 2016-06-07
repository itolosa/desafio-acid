class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.integer :status, null: false, default: 200
      t.timestamps null: false
    end

    # add index to ensure unicity
    add_index :users, :email, unique: true
  end
end
