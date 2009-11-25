#!/usr/bin/ruby
require 'rubygems'

class MagicMouse

  def initialize
  end 
  
  def mouse_is_being_touched 
  # This function should be used to detect if the user
  # is touching the mouse. This function should be called 
  # before any command, because if the user is not touching
  # the mouse, any other will return 0.
    return true unless _get_data == 0.0
    return false
  end

  def fingers
    # Returns the number of fingers that are touching the mouse.
    # This library doesn't support multi-touch for now.
    return (_get_data)[0].to_f
  end

  def x_position
    # Returns finger X axis position in the Mouse.
    return (_get_data)[5].to_f
  end

  def y_position
    # Returns finger Y axis position in the Mouse.
    return (_get_data)[6].to_f
  end

  def x_velocity
    # Returns finger X axis linear velocity.
    return (_get_data)[7].to_f
  end

  def y_velocity
    # Returns finger Y axis linear velocity.
    return (_get_data)[8].to_f
  end

  def angle
    # Returns finger's angle (this rocks)
    return (_get_data)[9].to_f
  end
  
  def major_axis
    # Returns major axis reading.
    return (_get_data)[10].to_f
  end
  
  def minor_axis
    # Returns minor axis reading.
    return (_get_data)[11].to_f
  end
  
  private # _get_data function should be used just inside the class
  def _get_data
    output = %x[#{Dir.pwd}/mouse/mouse]
    data = output.split("|")
    data = data[1];
    unless data
      return 0
    end
    return data.split
  end

end

t = MagicMouse.new
if t.mouse_is_being_touched
  10.times do |test| puts t.major_axis end
end