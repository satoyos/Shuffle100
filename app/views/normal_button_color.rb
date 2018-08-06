module NormalButtonColors
  def set_button_title_color(button)
    button.setTitleColor(:blue.uicolor, forState: :normal.uicontrolstate)
    button.setTitleColor(:red.uicolor, forState: :highlighted.uicontrolstate)
    button.setTitleColor(:light_gray.uicolor, forState: :disabled.uicontrolstate)
  end
end