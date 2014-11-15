module NormalButtonStyles
  def set_button_title_color
    setTitleColor(:blue.uicolor, forState: :normal.uicontrolstate)
    setTitleColor(:light_gray.uicolor, forState: :highlighted.uicontrolstate)
    setTitleColor(:light_gray.uicolor(0.5), forState: :disabled.uicontrolstate)
  end
end