module SelectSingerScreenDelegate
  def pickerView(pickerView, titleForRow: row, forComponent: component)
    singers[row].name
  end

  def pickerView(pickerView, widthForComponent: component)
    view.frame.size.width
  end
end