module HomeHelper
  def top_deals(limit=3)
    items = RemoteInventory.find_by_city_id(current_city_id, limit: limit)
  end
end
