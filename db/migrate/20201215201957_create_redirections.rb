class CreateRedirections < ActiveRecord::Migration[6.0]
  def change
    create_table :redirections do |t|
      t.integer :smartlink_id, null: false
      t.integer :language_id, null: false
      t.timestamps
    end

    add_index :redirections, [:smartlink_id, :language_id], unique: true, name: :ux_redirections

    add_foreign_key :redirections, :smartlinks, name: :fk_redirections_smartlink_id
    add_foreign_key :redirections, :languages, name: :fk_redirections_language_id
  end
end
