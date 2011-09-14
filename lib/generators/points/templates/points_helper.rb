module PointsHelper

 def options_for_points_action
   controllers_hash = Rails.application.routes.routes.inject({}) do |controller_actions, route|
     (controller_actions[route.requirements[:controller]] ||= []) << route.requirements[:action]
     controller_actions
   end.reject{|k, v| k.nil?}


   foo = controllers_hash.sort.collect do |arr|
     next if arr[0].match(/admin/)
     actions = arr[1] - ["destroy", "index", "edit", "show", "update"]
     [arr[0], actions.collect{|elem| [elem, "#{arr[0]}-#{elem}"] }.uniq.sort]
   end.compact
   grouped_options_for_select(foo)
 end


end
