class PointRedemption < ActiveRecord::Base
  belongs_to :user
  belongs_to :point

  validates_presence_of :user, :point, :value
  attr_accessible :user_id, :point_id, :value

  after_create :update_user_point_total

  scope :for_user, lambda {|x|
    if x
      where(:user_id => x)
    end
  }

  scope :for_point, lambda {|x|
    if x
      where(:point_id => x)
    end
  }

  private
  def update_user_point_total
    user.increment!(:points, self.value)
  end
end


