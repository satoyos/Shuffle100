class SpeedSettingLayout < MK::Layout
  include NormalButtonStyles

  attr_reader :slider, :rate_label, :try_button
  attr_accessor :sizes

  MIN_SPEED_RATE = 0.9
  MAX_SPEED_RATE = 1.1

  def layout
    background_color :white.uicolor
    @rate_label = add UILabel, :rate_label
    add UILabel, :x_label
    @slider = add UISlider, :rate_slider
    @try_button = add UIButton, :try_button
  end

  def rate_label_style
    text '0..0'
    text_alignment NSTextAlignmentCenter
    font :system.uifont(rate_label_height)
    size_to_fit
    center ['50%', '40%']
  end

  def x_label_style
    text '倍速'
    size [x_label_size, x_label_size * 2]
    frame from_bottom_right(:rate_label,
                            down: x_label_size / 2, right: x_label_size / 2)
    font :system.uifont(x_label_size / 2)
  end

  def rate_slider_style
    size ['50%', rate_vertical_blank]
    frame below(:rate_label, down: rate_vertical_blank)
    center x: '50%'
    minimum_value MIN_SPEED_RATE
    maximum_value MAX_SPEED_RATE
    value 1.0
  end

  def try_button_style
    title '試しに聞いてみる'
    font MDT::Font.body
    size ['80%', rate_vertical_blank]
    frame below(:rate_slider, down: rate_vertical_blank / 2)
    center x: '50%'
    set_button_title_color
  end

  def update_rate_label
    rate_label.text = '%.01f' % slider.value
  end

  def font_changed(notification)
    get(:try_button).titleLabel.font = MDT::Font.body
  end

  private

  def rate_label_height
    sizes.interval_label_height
  end

  def x_label_size
    sizes.interval_sec_label_size
  end

  def rate_vertical_blank
    sizes.interval_vertical_blank
  end
end