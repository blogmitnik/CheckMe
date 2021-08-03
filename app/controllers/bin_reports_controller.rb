class BinReportsController < ApplicationController
	def index
		if !query_params.empty?
			@bin_reports = BinReport.filtered(query_params)

			if !@bin_reports.empty?
				SearchHistory.insert_record(@bin_reports)
			else
				SearchHistory.insert_empty_record(query_params[:text])
			end
		end
	end

	private

	def query_params
		query_params = params[:query]
		query_params ? query_params.permit(:text) : {}
	end
end
