class VolumeSettingLayout < MK::Layout
  include NormalButtonStyles

  VERTICAL_BLANK_SIZE = 40

  def layout
    background_color :white.uicolor

    add UISlider, :slider
    add UIButton, :play_button
  end

  def slider_style
    size ['80%', VERTICAL_BLANK_SIZE]
    center ['50%', '40%']
  end

  def play_button_style
    title 'テスト音声を再生する'
    size ['80%', VERTICAL_BLANK_SIZE]
    frame below(:slider, down: VERTICAL_BLANK_SIZE)
    center x: '50%'
    set_button_title_color
  end
end