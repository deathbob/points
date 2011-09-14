class PointRedemptionsController < ApplicationController

  def index
    @point_redemptions = PointRedemption.for_user(params[:user_id]).
      for_point(params[:point_id]).
      order("created_at ASC")
  end

end

