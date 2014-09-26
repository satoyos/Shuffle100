class SizesIPhone
  PLAY_BUTTON_SIZE = 260
  SKIP_BUTTON_SIZE = 30

  def initialize
    puts "+ #{self.class} is selected."
  end

  def play_button_size
    PLAY_BUTTON_SIZE
  end

  def skip_button_size
    SKIP_BUTTON_SIZE
  end

end