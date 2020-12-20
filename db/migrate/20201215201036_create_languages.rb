class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :code, null: false, limit: 2
      t.string :name, null: false, limit: 50
      t.boolean :default, null: false, default: false
      t.timestamps
    end

    add_index :languages, :code, unique: true, name: :ux_languages_code
    add_index :languages, :name, unique: true, name: :ux_languages_name
  end
end
