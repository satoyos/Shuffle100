module NormalButtonStyles
  def set_button_title_color
    title_color :blue.uicolor
    title_color :red.uicolor, state: :highlighted.uicontrolstate
  end
end