class BinReport::Filter

  def filter(scope, query_params)
    if query_params[:text].present?
      scope = scope.where("sn = :text", text: "#{query_params[:text]}")
    end

    scope
  end

end