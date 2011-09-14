require 'points'
require 'rails'

module PointsApplicationControllerExtensions
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

module Points
  class Engine < Rails::Engine
    initializer 'myengine.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
#        extend MyModule::ClassMethods
#        include PointsApplicationControllerExtensions
      end
    end
  end
end
