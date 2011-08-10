module ServicesHelper
  def get_non_profit_name(id)
    return nil if id.to_i == 0
    return NonProfit.find(id).name
  end
end
