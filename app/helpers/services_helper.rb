module ServicesHelper
  def get_non_profit_name(id)
    return nil if id == nil
    return NonProfit.find(id).name
  end
end
