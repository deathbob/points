class PointsController < ApplicationController
  around_filter :award_points # you probably want to put this in your application_controller.rb

  def index
    @points = Point.all
  end

  def new
    @point = Point.new
  end

  def edit
    @point = Point.find(params[:id])
  end

  def create
    @point = Point.new(params[:point])
    if @point.save
      flash[:notice] = "Successfully created point"
    else
      flash[:alert] = "Failed to create point"
    end
    redirect_to points_path
  end

  def update
    @point = Point.find(params[:id])
    if @point.update_attributes(params[:point])
      flash[:notice] = "Successfully updated point"
    else
      flash[:alert] = "Failed to update point"
    end
    redirect_to point_path(@point)
  end

  def show
    @point = Point.find(params[:id])
  end

  def destroy
    @point.find(params[:id])
    if @point.destroy
      flash[:notice] = "Successfully deleted point"
    else
      flash[:alert] = "Failed to delete point"
    end
    redirect_to points_path


  end



private

  def award_points
    yield and return if current_user.try(:admin?)
    @point = Point.find_by_controller_and_action(params["controller"], params["action"])
    yield
    if @point
      # Setting @award_points in this method is just for developing so you can see how it
      #   would work, to really get the points in we ought to assign @award_points in each action
      #   that we want to give points out for.
      @award_points ||= ( response.code == '200' || flash[:notice].try(:match, /success/i) )
      @point.award(current_user, @award_points) if @award_points
    end
  end

end

