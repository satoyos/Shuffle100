class SelectSingerScreen < PM::Screen
  title '読手を選ぶ'

  def on_load
    # self.navigationController.navigationBar.translucent = false
    view.backgroundColor = :white.uicolor
    set_picker_view
  end

  def will_appear
    self.navigationItem.prompt = app_delegate.prompt
  end

  def should_autorotate
    false
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    3
  end

  def pickerView(pickerView, titleForRow: row, forComponent: component)
    %w(aaa bbb ccc)[row]
  end

  def pickerView(pickerView, widthForComponent: component)
    200
  end

  private

  def set_picker_view
    @picker_view = UIPickerView.alloc.init
    @picker_view.tap do |p_view|
      p_view.delegate = self
      p_view.dataSource = self
      p_view.showsSelectionIndicator = true
      p_view.selectRow(0, inComponent: 0, animated: false)
      view.addSubview(p_view)
    end
  end

end