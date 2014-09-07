class IntervalSettingLayout < MK::Layout
  include NormalButtonStyles

  SEC_LABEL_SIZE = 40
  VERTICAL_BLANK_SIZE = 40

  MIN_INTERVAL_VALUE = 0.5
  MAX_INTERVAL_VALUE = 2.0

  attr_reader :slider, :int_label

  def layout
    background_color :white.uicolor

    @int_label = add UILabel, :interval_label
    add UILabel, :sec_label
    @slider = add UISlider, :interval_slider
    add UIButton, :try_button
  end

  def interval_label_style
    text '0.00'
    size [200, 100]
    center ['50%', '40%']
    font :system.uifont(100)
  end

  def sec_label_style
    text '秒'
    size [SEC_LABEL_SIZE, SEC_LABEL_SIZE]
    frame from_bottom_right(:interval_label,
                            down: SEC_LABEL_SIZE / 2, right: SEC_LABEL_SIZE / 2)
    font :system.uifont(SEC_LABEL_SIZE / 2)
  end

  def interval_slider_style
    size ['80%', VERTICAL_BLANK_SIZE]
    frame below(:interval_label, down: VERTICAL_BLANK_SIZE)
    center x: '50%'
    minimum_value MIN_INTERVAL_VALUE
    maximum_value MAX_INTERVAL_VALUE
    value 1.0
  end

  def try_button_style
    title '試しに聞いてみる'
    size ['80%', VERTICAL_BLANK_SIZE]
    frame below(:interval_slider, down: VERTICAL_BLANK_SIZE / 2)
    center x: '50%'
    set_button_title_color
  end
end