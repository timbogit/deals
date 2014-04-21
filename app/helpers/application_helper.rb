module ApplicationHelper
  def current_city_id
    params[:city_id] || 6575
  end
end
