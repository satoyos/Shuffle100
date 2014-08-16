class WhatsNextLayout < MotionKit::Layout
  def layout
    background_color :white.uicolor
    add UIButton, :refrain_button
  end

  def refrain_button_style
    size ['80%', 30]
    center ['50%', '50%']
    title '下の句をもう一度読む'
    title_color :blue.uicolor
    title_color :red.uicolor, state: :highlighted.uicontrolstate
  end
end