class SearchHistoriesController < ApplicationController
	def index
		@histories = SearchHistory.all.order('created_at DESC')
	end
end
