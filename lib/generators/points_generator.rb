require 'rails/generators'
require 'rails/generators/migration'

class PointsGenerator < Rails::Generators::Base
  desc "This generator creates the points model and table"
  include Rails::Generators::Migration

  def self.source_root
  # This must be defined.  It tells the generator where to find the template for your migration.
    File.join(File.dirname(__FILE__), 'points/templates')
  end

  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      sleep(1.1) # hack to not get duplicate migration version numbers
      t = Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def install
    ["point", "point_redemption"].each do |x|
      model = "app/models/#{x}.rb"
      if File.exists?(model)
        puts "Well, Fuck." # Need to figure out how to ask the user if they would like to overwrite their model.
      else
        template "#{x}.rb", model
      end
    end

    helper = 'app/helpers/points_helper.rb'
    if File.exists?(helper)
      puts "Damn, him too?" # Again, figure out how to ask the user if they want to overwrite it.
    else
      template 'points_helper.rb', helper
    end

    ['points_controller.rb', 'point_redemptions_controller.rb'].each do |x|
      controller = "app/controllers/#{x}"
      if File.exists?(controller)
        puts "Damn, him too?" # Again, figure out how to ask the user if they want to overwrite it.
      else
        template x, controller
      end
    end
  end

  # This method is pulling all of the migration data from the migration.rb template.
  # After it pulls the migration date, it generates a migration in the main application
  # called create_contents...
  # You can change the name of this if and when you make your own engine.
  def create_migration_file
    migration_template 'create_points.rb', 'db/migrate/create_points.rb'
    migration_template 'create_point_redemptions.rb', 'db/migrate/create_point_redemptions.rb'
    migration_template 'add_point_indices.rb', 'db/migrate/add_point_indices.rb'
    migration_template 'add_points_to_users.rb', 'db/migrate/add_points_to_users.rb'
  end
end


