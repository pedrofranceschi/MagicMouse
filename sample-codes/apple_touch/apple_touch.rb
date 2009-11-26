# apple_touch.rb
# by pH - iBlogeek.com
#
# MagicMouse Library Sample Code - Ruby
# http://www.github.com/pedrofranceschi/MagicMouse
#
# pedrohfranceschi@gmail.com

#!/usr/bin/ruby
require '../../magicmouse.rb' # requires the main library
mouse = MagicMouse.new # initialization of magicmouse library

if mouse.mouse_is_being_touched # we need to check if the user is touching the mouse, otherwise, no data will be returned.
  if (mouse.y_position < 0.127) and (mouse.x_position > 0.404 and mouse.x_position < 0.627) # checks if the user is touching this coordinates (apple logo's area in the mouse)
    puts "TOUCHING THE APPLE!"
  else # if user is NOT touching the apple..
    puts "NOT TOUCHING THE APPLE!"
  end
else
  puts "You are not touching the mouse." # if the mouse isn't being touched...
end