class DealsController < ApplicationController
  def show
    @deal = RemoteInventory.find_by_id params[:id]
  end
end
