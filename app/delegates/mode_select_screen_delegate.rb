module ModeSelectScreenDelegate
  def pickerView(pickerView, titleForRow: row, forComponent: component)
    recite_modes[row].name + recite_modes[row].description
  end

  def pickerView(pickerView, widthForComponent: component)
    view.frame.size.width
  end
end