class SizesIPhone
  PLAY_BUTTON_SIZE = 260
  SKIP_BUTTON_SIZE = 30
  WHATS_NEXT_BUTTON_HEIGHT = 50
  IMAGE_OFFSET_X = 30

  def initialize
    puts "+ #{self.class} is selected." if BW2.debug?
  end

  def play_button_size
    PLAY_BUTTON_SIZE
  end

  def skip_button_size
    SKIP_BUTTON_SIZE
  end

  def whats_next_button_height
    WHATS_NEXT_BUTTON_HEIGHT
  end

  def image_offset_x
    IMAGE_OFFSET_X
  end
end