require 'rails/generators'

class PointsHamlViewsGenerator < Rails::Generators::Base
  desc "This generator creates the views for Points"

  def self.source_root
    File.join(File.dirname(__FILE__), 'points/points_haml_views_templates')
  end

  def install
    puts "Installing Views"
    directory 'points', 'app/views/points'
    directory 'point_redemptions', 'app/views/point_redemptions'
  end

end
