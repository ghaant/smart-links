class CreateSmartlinks < ActiveRecord::Migration[6.0]
  def change
    create_table :smartlinks do |t|
      t.string :slug, null: false, limit: 50
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :smartlinks, :slug, unique: true, name: :ux_smartlinks_slug
    add_index :smartlinks, :user_id, name: :ix_smartlinks_user_id
    add_foreign_key :smartlinks, :users, name: :fk_smartlinks_user_id
  end
end
