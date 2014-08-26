module NormalButtonStyles
  def set_button_title_color
    setTitleColor(:blue.uicolor, forState: :normal.uicontrolstate)
    setTitleColor(:blue.uicolor.mix_with(:black.uicolor, 0.75), forState: :highlighted.uicontrolstate)
  end
end