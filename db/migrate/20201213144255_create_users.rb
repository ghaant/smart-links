class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 255, null: false
      t.string :email, limit: 50, null: false
      t.string :password_digest, limit: 255, null: false
      t.timestamps
    end

    add_index :users, :email, unique: true, name: :ux_users_email
  end
end
