#!/usr/bin/ruby
require 'rubygems'

class MagicMouse

  def initialize
    check_for_files
    refresh
  end 
  
  def check_for_files
    unless File.exists?("/usr/bin/magic_mouse_rb")
      raise "Missing file: /usr/bin/magic_mouse_rb. To install this file, type 'make install' inside the magic_mouse/mouse/ downlaoded folder."
    end
  end

  def mouse_is_being_touched 
    # This function should be used to detect if the user
    # is touching the mouse. This function should be called 
    # before any command, because if the user is not touching
    # the mouse, any other will return 0.
    return true unless $DATA == 0.0
    return false
  end

  def fingers
    # Returns the number of fingers that are touching the mouse.
    # This library doesn't support multi-touch for now.
    return $DATA[0].to_f
  end

  def x_position
    # Returns finger X axis position in the Mouse.
    return $DATA[5].to_f
  end

  def y_position
    # Returns finger Y axis position in the Mouse.
    return $DATA[6].to_f
  end

  def x_velocity
    # Returns finger X axis linear velocity.
    return $DATA[7].to_f
  end

  def y_velocity
    # Returns finger Y axis linear velocity.
    return $DATA[8].to_f
  end

  def angle
    # Returns finger's angle (this rocks)
    return $DATA[9].to_f
  end

  def major_axis
    # Returns major axis reading.
    return $DATA[10].to_f
  end

  def minor_axis
    # Returns minor axis reading.
    return $DATA[11].to_f
  end
  
  def refresh
    $DATA = _get_data
  end

  private # _get_data function should be used just inside the class
  def _get_data
    output = %x[/usr/bin/magic_mouse_rb]
    db = output.split("|")
    db = db[1];
    unless db
      return 0
    end
    return db.split
  end

end