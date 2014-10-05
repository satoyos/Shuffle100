class SizesIPad < SizesIPhone
  IMAGE_OFFSET_X_IPAD = 200

  def play_button_size
    super * 2
  end

  def skip_button_size
    super * 2
  end

  def whats_next_button_height
    super * 2
  end

  def image_offset_x
    IMAGE_OFFSET_X_IPAD
  end

  def nav_bar_button_size
    super * 2
  end

  def interval_sec_label_size
    super * 2
  end

  def interval_vertical_blank
    super * 2
  end

  def interval_label_height
    super * 2
  end
end