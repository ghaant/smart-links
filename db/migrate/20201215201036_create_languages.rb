class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :code, null: false, limit: 2
      t.boolean :default, null: false, default: false
      t.timestamps
    end

    add_index :languages, :code, unique: true, name: :ux_languages_code
  end
end
