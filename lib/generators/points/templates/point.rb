class Point < ActiveRecord::Base
  # cooldown is the number of seconds that must pass before the point can be awarded again.
  # Only applies to repeatable points.

  has_many :point_redemptions
  has_many :users, :through => :point_redemptions

  validates_presence_of :controller, :action, :value

  attr_accessible :description, :repeatable, :cooldown, :controller_and_action, :value, :controller, :action
  attr_accessor :controller_and_action

  def controller_and_action
    "#{controller}-#{action}"
  end

  def controller_and_action=(val)
    self.controller, self.action = val.split('-')
  end

  # I realize this is kind of verbose, but I couldn't think of a way to maintain correctness and shorten it.  If you can by all means have at it.
  def award(user, val = nil)
    return unless user
    previous = PointRedemption.where(:user_id =>  user.id, :point_id => self.id).order("updated_at DESC").first
    if previous
      if self.repeatable? && cooldown_over?(previous)
        award = true
      else
        award = false
      end
    else
     award = true
    end
    if award
      if val.is_a?(Integer)
        PointRedemption.create(:value => val, :point_id => self.id, :user_id => user.id)
      else
        PointRedemption.create(:value => self.value, :point_id => self.id, :user_id => user.id)
      end
    end
  end

  def award_points_for_friendship(user, friend)
    return unless user && friend
    raise "Friendship Points are not repeatable" if self.repeatable? # Infinite recursion below if allowed to repeat.
    previous = PointRedemption.where(:user_id => user.id, :point_id => self.id).order("updated_at DESC").first
    return if previous

    if PointRedemption.create(:point_id => self.id, :user_id => user.id) # Reciprocate
      self.award_for_friendship(friend, user)
    end
  end

  def cooldown_over?(point_redemption)
    (point_redemption.updated_at + self.cooldown.seconds) < Time.now
  end

end
