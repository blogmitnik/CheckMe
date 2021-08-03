require 'fileutils'
require "activerecord-import/base"
ActiveRecord::Import.require_adapter('mysql2')

class BinReport < ApplicationRecord
  belongs_to :source_file
  validates :source_file_id, :time, :name, :model, :sn, :current, :bin, :created_at, :updated_at, presence: true

  paginates_per 1000

  before_validation :set_uuid, on: :create

  scope :filtered, ->(query_params) { BinReport::Filter.new.filter(self, query_params) }

  def set_uuid
    self.id = SecureRandom.uuid
  end

  # The 'import' function can be used both on web and rake script
  def self.import_data(file, filename)
    # Check filename
    if csvfile = SourceFile.find_by_file_name(filename)
      csvfile_id = csvfile.id
    else
      line_count = CSV.open(file, "r", :encoding => 'utf-8').readlines.count
      uuid = SecureRandom.uuid
      csvfile = SourceFile.create(id: uuid, file_name: filename, total_row: line_count)
      csvfile_id = csvfile.id
    end

    GC.disable

    BinReport.transaction do
      records = []
      columns = [:id, :source_file_id, :time, :name, :model, :sn, :current, :bin]
      # Define CSV header columns
      column_header = ['Time', 'Name', 'Model', 'SN', 'Current', 'BIN']
      
      CSV.foreach(file, **{encoding: "utf-8", quote_char: '"', col_sep: ',', row_sep: :auto, headers: column_header}).with_index(0) do |row, rowno|
      	if rowno > 0 and rowno < line_count.to_i
      	  if row['Current'].to_f >= 0.3801
          	row['BIN'] = 'A'
          elsif 0.3800 >= row['Current'].to_f && row['Current'].to_f >= 0.3701
          	row['BIN'] = 'B1'
          elsif 0.3700 >= row['Current'].to_f && row['Current'].to_f >= 0.3601
          	row['BIN'] = 'B2'
          elsif 0.3600 >= row['Current'].to_f && row['Current'].to_f >= 0.3501
          	row['BIN'] = 'B3'
          elsif 0.3500 >= row['Current'].to_f && row['Current'].to_f >= 0.3301
          	row['BIN'] = 'C1'
          elsif 0.3300 >= row['Current'].to_f && row['Current'].to_f >= 0.3249
          	row['BIN'] = 'C2'
          elsif 0.3248 >= row['Current'].to_f
          	row['BIN'] = 'C3'
          else
          	row['BIN'] = 'No data'
          end

          time_now = Time.now.strftime('%Y-%m-%d %H:%M:%S').to_s
          report_uuid = SecureRandom.uuid
          record = [report_uuid, csvfile_id, row['Time'].strip.to_s, row['Name'].strip.to_s, row['Model'].strip.to_s, row['SN'].strip.to_s, row['Current'].to_f, row['BIN'].strip.to_s, time_now, time_now]
          records << record
        end
      end

      values = records.map{ |record| "('#{record[0]}', '#{record[1]}', '#{record[2]}', '#{record[3]}', '#{record[4]}', '#{record[5]}', #{record[6]}, '#{record[7]}', '#{record[8]}', '#{record[9]}')" }.join(",")
      sql = "INSERT INTO `#{self.table_name}` (`id`,`source_file_id`,`time`,`name`,`model`,`sn`,`current`,`bin`,`created_at`,`updated_at`) VALUES #{values}"
      ActiveRecord::Base.connection_pool.with_connection do |conn|
        conn.execute(sql)
      end
    end
  end

end
