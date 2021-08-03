class SourceFile < ApplicationRecord
	#attr_accessible :post_id, :file_name, :total_row, :published_at

	has_many :bin_reports, dependent: :destroy

	validates :file_name, presence: true, uniqueness: true
	validates :total_row, numericality: { only_integer: true }

	before_create do
		file_extension = File.extname(self.file_name)
		if !file_extension.downcase == '.csv'
		  false
		end
	end

	before_validation :set_uuid, on: :create

	def set_uuid
		self.id = SecureRandom.uuid
	end
end
