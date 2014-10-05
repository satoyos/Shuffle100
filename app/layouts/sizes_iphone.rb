class SizesIPhone
  PLAY_BUTTON_SIZE = 260
  SKIP_BUTTON_SIZE = 30
  WHATS_NEXT_BUTTON_HEIGHT = 50
  IMAGE_OFFSET_X = 30
  NAV_BAR_BUTTON_SIZE = 25
  INTERVAL_SEC_LABEL_SIZE = 40
  INTERVAL_LABEL_HEIGHT = 100
  INTERVAL_VERTICAL_BLANK = INTERVAL_LABEL_HEIGHT * 4 / 10

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

  def nav_bar_button_size
    NAV_BAR_BUTTON_SIZE
  end

  def interval_sec_label_size
    INTERVAL_SEC_LABEL_SIZE
  end

  def interval_vertical_blank
    INTERVAL_VERTICAL_BLANK
  end

  def interval_label_height
    INTERVAL_LABEL_HEIGHT
  end
end