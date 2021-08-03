class CreateSearchHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :search_histories, id: false do |t|
      t.string :id, limit: 36,  primary_key: true, null: false
      t.string :time,           null: true
      t.string :name,           null: true
      t.string :model,          null: true
      t.string :sn,             null: false
      t.float :current,         null: true, precision: 5, scale: 2
      t.string :bin,            null: true

      t.timestamps
    end

    add_index :search_histories, :sn
  end
end
