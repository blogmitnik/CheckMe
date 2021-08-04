class SearchHistoriesController < ApplicationController
	def index
		@histories = SearchHistory.all
	end
end
