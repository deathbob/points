module Points
  # This require basically states that we're going to require the engine
  # if you are using rails and your rails version is 3.x..
  require 'points/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3

end
