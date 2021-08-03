class CreateBinReports < ActiveRecord::Migration[6.0]
  def change
    create_table :bin_reports, id: false do |t|
      t.string :id, limit: 36,  primary_key: true, null: false
      t.string :source_file_id, null: false
      t.string :time,           null: false
      t.string :name,           null: false
      t.string :model,          null: false
      t.string :sn,             null: false
      t.float :current,         null: false, precision: 5, scale: 2
      t.string :bin,            null: false

      t.timestamps
    end

    add_index :bin_reports, :sn
    add_index :bin_reports, :source_file_id
  end
end
