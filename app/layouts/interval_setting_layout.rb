class IntervalSettingLayout < MK::Layout
  include NormalButtonStyles

  MIN_INTERVAL_VALUE = 0.5
  MAX_INTERVAL_VALUE = 2.0

  attr_reader :slider, :int_label, :try_button
  attr_accessor :sizes

  def layout
    background_color :white.uicolor
    @int_label = add UILabel, :interval_label
    add UILabel, :sec_label
    @slider = add UISlider, :interval_slider
    @try_button = add UIButton, :try_button
  end

  def interval_label_style
    text '0.00'
    size [interval_label_height * 2, interval_label_height]
    center ['50%', '40%']
    font :system.uifont(interval_label_height)
  end

  def sec_label_style
    text '秒'
    size [sec_label_size, sec_label_size]
    frame from_bottom_right(:interval_label,
                            down: sec_label_size / 2, right: sec_label_size / 2)
    font :system.uifont(sec_label_size / 2)
  end

  def interval_slider_style
    size ['80%', interval_vertical_blank]
    frame below(:interval_label, down: interval_vertical_blank)
    center x: '50%'
    minimum_value MIN_INTERVAL_VALUE
    maximum_value MAX_INTERVAL_VALUE
    value 1.0
  end

  def try_button_style
    title '試しに聞いてみる'
    font MDT::Font.body
    size ['80%', interval_vertical_blank]
    frame below(:interval_slider, down: interval_vertical_blank / 2)
    center x: '50%'
    set_button_title_color
  end

  def update_interval_label
    int_label.text = '%.02f' % slider.value
  end

  private

  def interval_label_height
    sizes.interval_label_height
  end

  def sec_label_size
    sizes.interval_sec_label_size
  end

  def interval_vertical_blank
    sizes.interval_vertical_blank
  end
end