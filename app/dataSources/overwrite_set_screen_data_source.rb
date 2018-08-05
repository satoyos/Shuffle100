module OverwriteSetScreenDataSource
  def pickerView(pickerView, titleForRow: row, forComponent: component)
    fuda_sets[row].name
  end
end