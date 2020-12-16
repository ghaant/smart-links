class CreateSmartlinks < ActiveRecord::Migration[6.0]
  def change
    create_table :smartlinks do |t|
      t.string :slug, null: false, limit: 50
      t.timestamps
    end

    add_index :smartlinks, :slug, unique: true, name: :ux_smartlinks_slug
  end
end
