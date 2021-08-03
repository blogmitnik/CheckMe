class SearchHistory < ApplicationRecord
  validates :sn, :created_at, :updated_at, presence: true

  paginates_per 1000

  before_validation :set_uuid, on: :create

  def set_uuid
    self.id = SecureRandom.uuid
  end

  def self.insert_record(records)
  	uuid = SecureRandom.uuid
  	time_now = Time.now.strftime('%Y-%m-%d %H:%M:%S').to_s

  	records.each do |record|
  	  SearchHistory.create(id: uuid, time: record.time.to_s, name: record.name.to_s, model: record.model.to_s, sn: record.sn.to_s, current: record.current.to_f, bin: record.bin.to_s, created_at: time_now, updated_at: time_now)
  	end
  end

  def self.insert_empty_record(sn)
  	uuid = SecureRandom.uuid
  	time_now = Time.now.strftime('%Y-%m-%d %H:%M:%S').to_s

  	SearchHistory.create(id: uuid, sn: sn.to_s, created_at: time_now, updated_at: time_now)
  end
end
